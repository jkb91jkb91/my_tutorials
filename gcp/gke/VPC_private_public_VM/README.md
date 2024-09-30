#**************************************VPC********************************************
#Tworzenie VPC, bgp-routing(regional lub global)(subnet-moode  custom lub auto)
gcloud compute networks create my-vpc \
  --subnet-mode=custom \
  --bgp-routing-mode=regional

#Dodanie podsieci VPC PUBLIC < to tylko zalozenie
gcloud compute networks subnets create public-subnet \
  --network=my-vpc \
  --region=us-central1 \
  --range=10.0.1.0/24

#Dodanie podsieci VPC Private < to tylko zalozenie
gcloud compute networks subnets create private-subnet \
  --network=my-vpc \
  --region=us-central1 \
  --range=10.0.2.0/24


#PUBLIC TRAFFIC
#Utworz trase do Default Gateway
#Trasy sa globalne , musisz bazowac na TAGach
#Twoje instancje musza posiadac TAGi
gcloud compute routes create route-to-internet-for-subnet \
  --network=my-vpc \
  --destination-range=0.0.0.0/0 \
  --next-hop-gateway=default-internet-gateway \
  --tags=subnet-public

#PRIVATE TRAFFIC
#router
gcloud compute routers create my-router \
  --network=my-vpc
  --region=us-central1
#CloudNAT
gcloud compute routers nats create my-nat-config \
  --router=my-router \
  --auto-allocate-nat-external-ips \
  --nat-custom-subnet-ip-ranges=private-subnet \
  --region=us-central1
#open ssh to whole VPC>required to connect via Identity-Aware Proxy (IAP)
gcloud compute firewall-rules create allow-ssh-vpc-wide \
  --network=my-vpc \
  --allow=tcp:22 \
  --source-ranges=0.0.0.0/0 \
  --direction=INGRESS
#Use
#Prerequisuite >> VM in private subnet exists
gcloud compute ssh COMPUTE_ENGINE_NAME   --zone=us-central1-c   --tunnel-through-iap
