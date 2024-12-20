


# ************************************************************************  VPC ***********************************************************
# CREATE VPC
gcloud compute networks create private-vpc \
    --subnet-mode=custom \
    --bgp-routing-mode=regional


# CREATE SUBNET1
gcloud compute networks subnets create private-subnet \
    --network=private-vpc \
    --region=us-central1 \
    --range=10.0.0.0/24 \

# CREATE SUBNET2
gcloud compute networks subnets create private-subnet1 \
    --network=private-vpc \
    --region=us-central1 \
    --range=10.0.1.0/24 

# CREATE ROUTER
gcloud compute routers create my-router \
    --network=private-vpc \
    --region=us-central1

# CREATE NAT
gcloud compute routers nats create my-nat-config \
    --router=my-router \
    --auto-allocate-nat-external-ips \
    --nat-custom-subnet-ip-ranges=private-subnet \
    --region=us-central1

# UNBLOCK 22 IN WHOLE VPC
gcloud compute firewall-rules create allow-ssh \
    --network=private-vpc \
    --allow=tcp:22 \
    --source-ranges=0.0.0.0/0 \
    --description="Allow SSH access on port 22"

# ALLOW PING
gcloud compute firewall-rules create allow-icmp \
    --network=private-vpc \
    --allow=icmp \
    --source-ranges=0.0.0.0/0 \
    --description="Allow ICMP traffic (ping)"

# ALLOW PORT 80 in whole VPC
gcloud compute firewall-rules create allow-http-vpc \
    --network=private-vpc \
    --allow=tcp:80 \
    --source-ranges=10.0.0.0/16 \
    --description="Allow HTTP traffic on port 80 within the entire VPC"

