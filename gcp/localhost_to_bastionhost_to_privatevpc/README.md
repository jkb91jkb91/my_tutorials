


# ************************************************************************  VPC ***********************************************************
# CREATE VPC
gcloud compute networks create private-vpc \
    --subnet-mode=custom \
    --bgp-routing-mode=regional


# CREATE PRIVATE SUBNET
gcloud compute networks subnets create private-subnet \
    --network=private-vpc \
    --region=us-central1 \
    --range=10.0.0.0/24 \

# CREATE PUBLIC SUBNET
gcloud compute networks subnets create public-subnet \
  --network=my-vpc \
  --region=us-central1 \
  --range=10.0.3.0/24


# CRETE ROUTE TO PUBLIC SUBNET
gcloud compute routes create route-to-internet-for-subnet \
  --network=private-vpc \
  --destination-range=0.0.0.0/0 \
  --next-hop-gateway=default-internet-gateway

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


# ******************************************************************** VM PRIVATE ***************************************************************
gcloud compute instances create my-vm-private-vpc \
    --zone=us-central1-a \
    --subnet=private-subnet \
    --no-address \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --machine-type=e2-micro \
    --boot-disk-size=10GB \
    --network=private-vpc

# **************************************************************** VM DEFAULT ********************************************************************
gcloud compute instances create my-vm \
    --zone=us-central1-a \
    --network=private-vpc \
    --subnet=public-subnet




# CREATE SSH KEY AND COPY PUB TO PUBLIC VM TO AUTHORIZED KEYS
ssh  -i ~/.ssh/gcp bieda2q_gmail_com@35.226.199.36 # Should work  


