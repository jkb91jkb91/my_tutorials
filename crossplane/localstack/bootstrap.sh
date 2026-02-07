#!/bin/bash

FAKE_CONFIG_AWS="$HOME/.aws-fake/fake-credentials"
CONFIG_KIND="./kind-config"
PROVIDER_AWS="./provider"
PROVIDER_CONFIG="./provider-config"
LOCALSTACK_SERVICES="s3,sts,iam,sqs"


#*************************************************************************************************************************#
#*DOCUMENTATION: https://docs.localstack.cloud/aws/integrations/infrastructure-as-code/crossplane/?utm_source=chatgpt.com #
#*************************************************************************************************************************#

check_if_kind_installed() {
    which kind > 2&>1
    [ $? == 0 ] && echo "KIND: Installed" || { echo "KIND: Not installed"; exit 1; }
}

start_localstack() {
    docker run --rm -d --name localstack -p 4566:4566 -e SERVICES="$LOCALSTACK_SERVICES" -e DEBUG=1 localstack/localstack
}
start_kind() {
  kind create cluster --name cross --config $CONFIG_KIND/config-for-crossplane.yaml
}

crossplane_install() {
  echo "**************************************************************************"
  echo "*************** INSTALL CROSSPLANE HELM CHART  ***************************"
  echo "**************************************************************************"
  echo "**************************************************************************"
  helm repo add crossplane-stable https://charts.crossplane.io/stable
  helm repo update
  helm install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace
  kubectl -n crossplane-system rollout status deploy/crossplane --timeout=300s
  kubectl -n crossplane-system rollout status deploy/crossplane-rbac-manager --timeout=300s || true

}

aws_providers_install() {
  echo "**************************************************************************"
  echo "**********************. INSTALL AWS PROVIDER  ****************************"
  echo "**************************************************************************"
  echo "**************************************************************************"
  cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-sqs
spec:
  package: xpkg.upbound.io/upbound/provider-aws-sqs:v0.40.0
EOF

  kubectl wait --for=condition=Healthy --timeout=300s provider.pkg.crossplane.io/provider-aws-sqs


cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-s3
spec:
  package: xpkg.upbound.io/upbound/provider-aws-s3:v0.40.0
EOF

kubectl wait --for=condition=Healthy --timeout=300s provider.pkg.crossplane.io/provider-aws-s3
}

config_provider() {
  echo "**************************************************************************"
  echo "*********************** CONFIG PROVIDER  ****************************"
  echo "**************************************************************************"
  echo "**************************************************************************"
  CONTROL_PLANE=$(docker ps --format '{{.Names}}' | grep control-plane) 
  LOCALSTACK_IP=$(docker exec -it $CONTROL_PLANE sh -lc "ip route | awk '/default/ {print \$3}'")
  echo "LOCALSTACK_IP=$LOCALSTACK_IP"
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: localstack-aws-secret
stringData:
  creds: |
    [default]
    aws_access_key_id = test
    aws_secret_access_key = test
EOF

cat <<EOF | kubectl apply -f -
apiVersion: aws.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  credentials:
    source: Secret
    secretRef:
      name: localstack-aws-secret
      namespace: default
      key: creds
  endpoint:
    hostnameImmutable: true
    services: [iam, s3, sqs, sts]
    url:
      type: Static
      static: http://172.18.0.1:4566
  skip_credentials_validation: true
  skip_metadata_api_check: true
  s3_use_path_style: true
EOF


}

deploy_mr_s3() {
  echo "**************************************************************************"
  echo "************************* MANAGED RESOURCE S3 ****************************"
  echo "**************************************************************************"
  echo "**************************************************************************"
  cat <<EOF | kubectl apply -f -
apiVersion: s3.aws.upbound.io/v1beta1
kind: Bucket
metadata:
  name: crossplane-test-bucket
spec:
  forProvider:
    region: us-east-1
EOF
}


main() {
    check_if_kind_installed
    start_localstack
    start_kind
    crossplane_install
    #sleep 200s # After crossplane wee ned to wait
    aws_providers_install
    config_provider
    deploy_mr_s3
}

main