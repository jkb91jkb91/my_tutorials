
#PREREQUSUITE
1) Create artifactory on GCLOUD > mysimpleappdocker
2) Build Image > docker build -t simple-app-green .
3) Tag IMAGE   >  docker tag simple-app  us-central1-docker.pkg.dev/stronki-429707/mysimpleappdockerrepo/app:v1
4) Push IMAGE > docker push  us-central1-docker.pkg.dev/stronki-429707/mysimpleappdockerrepo/app:v2


# Create TEMPLATE
gcloud compute instance-templates create my-template-v1 \
    --machine-type=e2-micro \
    --metadata=startup-script='#!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    gcloud auth configure-docker us-central1-docker.pkg.dev --quiet
    sudo docker pull us-central1-docker.pkg.dev/stronki-429707/mysimpleappdockerrepo/app:v1 || echo "Failed to pull Docker image"
    sudo docker run -d -p 8080:80 us-central1-docker.pkg.dev/stronki-429707/mysimpleappdockerrepo/app:v1' \
    --tags=http-server \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-standard

# Create Instance Group

gcloud compute instance-groups managed create NAME --template=my-template-v1 --size=1 --zone=us-central1-c

# SET AUTOSCALLING
gcloud compute instance-groups managed set-autoscaling NAME \
  --max-num-replicas=3 \
  --min-num-replicas=1 \
  --target-cpu-utilization=0.6 \
  --cool-down-period=90 \
  --zone=us-central1-c

# Update locally image
docker build -t simple-app-green .
docker tag simple-app  us-central1-docker.pkg.dev/stronki-429707/mysimpleappdockerrepo/app:v1
docker push  us-central1-docker.pkg.dev/stronki-429707/mysimpleappdockerrepo/app:v2


# NEW TEMPLATE
gcloud compute instance-templates create my-template-v2 \
    --machine-type=e2-micro \
    --metadata=startup-script='#!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    gcloud auth configure-docker us-central1-docker.pkg.dev --quiet
    sudo docker pull us-central1-docker.pkg.dev/stronki-429707/mysimpleappdockerrepo/app:v2
    sudo docker run -d -p 8080:80 us-central1-docker.pkg.dev/stronki-429707/mysimpleappdockerrepo/app:v2' \
    --tags=http-server \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-standard

# ROLLING UPDATE
gcloud compute instance-groups managed rolling-action start-update NAME \
    --version=template=my-template-v2 \
    --zone=us-central1-c
