# CREATE VM IN PRIVATE VPC
# VPC NAME=private-vpc
# SUBNET NAME=private-subnet
gcloud compute instances create my-vm \
    --zone=us-central1-a \
    --subnet=private-subnet \
    --no-address \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --machine-type=e2-micro \
    --boot-disk-size=10GB \
    --network=private-vpc

# CREATE VM 2 IN PRIVATE VPC
# VPC NAME=private-vpc
# SUBNET NAME=private-subnet2
gcloud compute instances create my-vm-2 \
    --zone=us-central1-a \
    --subnet=private-subnet2 \
    --no-address \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --machine-type=e2-micro \
    --boot-disk-size=10GB \
    --network=private-vpc

