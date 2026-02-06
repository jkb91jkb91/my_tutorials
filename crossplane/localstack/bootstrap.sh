#!/bin/bash


FAKE_CONFIG_AWS="$HOME/.aws-fake/fake-credentials"
CONFIG_KIND="./kind-config"
PROVIDER_AWS="./provider"
PROVIDER_CONFIG="./provider-config"



check_if_kind_installed() {
    which kind > 2&>1
    [ $? == 0 ] && echo "KIND: Installed" || { echo "KIND: Not installed"; exit 1; }
}
check_aws_config_file() {
  # Check if config exists as prerequisuite
  [ -e $FAKE_CONFIG_AWS ] && echo "FILE: $FAKE_CONFIG_AWS exists " || echo " You have to create file: $FAKE_CONFIG_AWS with entry:
  [default]
  aws_access_key_id = test
  aws_secret_access_key = test
  "
  [ -e $CONFIG_KIND ] && echo "FOLDER: $CONFIG_KIND exists " || echo " You have to create folder: $CONFIG_KIND"
  [ -e $PROVIDER_AWS ] && echo "FOLDER: $PROVIDER_AWS exists " || echo " You have to create folder: $PROVIDER_AWS"
  [ -e $PROVIDER_CONFIG ] && echo "FOLDER: $PROVIDER_CONFIG= exists " || echo " You have to create folder: $PROVIDER_CONFIG="
}

start_kind() {
  kind create cluster --name cross --config $CONFIG_KIND/config-for-crossplane.yaml
}

crossplane_install() {
  helm repo add crossplane-stable https://charts.crossplane.io/stable
  helm repo update
  helm install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace
  sleep 240s
}

aws_provider_install() {
  echo "**************************************************************************"
  echo "**********************. INSTALL AWS PROVIDER  ****************************"
  echo "**************************************************************************"
  echo "**************************************************************************"
  kubectl apply -f $PROVIDER_AWS/provider.yaml
}

localstack_aws_auth() {
  echo "**************************************************************************"
  echo "*********************** LOCALSTACK AWS AUTH  ****************************"
  echo "**************************************************************************"
  echo "**************************************************************************"
  kubectl create secret generic aws-creds \
  -n crossplane-system \
  --from-file=creds=$FAKE_CONFIG_AWS
  kubectl apply -f $PROVIDER_CONFIG/providerConfigLocalStack.yaml
}

deploy_mr_s3() {
  echo "**************************************************************************"
  echo "************************* MANAGED RESOURCE S3 ****************************"
  echo "**************************************************************************"
  echo "**************************************************************************"
  kubectl apply -f ./managed-resources/s3-mr.yaml
}


main() {
    check_if_kind_installed
    check_aws_config_file
    start_kind
    crossplane_install
    aws_provider_install
    localstack_aws_auth
    deploy_mr_s3
}

main