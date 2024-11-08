
# ******************************************ADMIN****************************************
```
SPRAWDZ Z JAKIEGO KONTA KORZYSTASZ
gcloud auth list
gcloud compute [PRESS TAB AND YOU WILL SE MANY OPTIONS]

Wyswietlenie dostepnych konfiguracji
gcloud config configurations list

Aktywacja jednej z tych konfiguracji
gcloud config configurations activate NAZWA

Usuniecie konfiguracji
gcloud config configurations delete CONFIG_NAME
```



#WEWNATRZ KONFIGURACJI WYBRANEJ
```
#Szczegoly tylko biezacej konfiguracji
gcloud config list

#Wyswietlenie projektow w danej konfiguracji
gcloud projects list

#Stworzenie projektu po wybraniu konfiguracji
gcloud projects create
```



#USTAWIENIA PO UTWORZENIU KONFIGURACJI
```
#Ustawienie projektu
gcloud config set project ID_PROJECT
#ustawienia maila
gcloud config set account EMAIL
#Opis projektu
gcloud projects describe PROJECT_NAME
```


#Tworzenie nowej konfiguracji
```
gcloud config configurations create <nazwa-konfiguracji>
gcloud config configurations activate <nazwa-konfiguracji>
gcloud auth login
gclod projects list
gcloud config set project ID_PROJECT
gcloud config set account EMAIL
gcloud config set compute/zone europe-west1-b
```

#SERVICE ACCOUNT
```
#listowanie SA
gcloud iam service-accounts list
#tworzenie service-account
gcloud iam service-accounts create SA_NAME --project=project_id --display-name="name"
#binding z role
gcloud projects add-iam-policy-binding stronki-429707 --member serviceAccount:kuberne@stronki-429707.iam.gserviceaccount.com --role "roles/dns.admin"
```


#LISTOWANIE
```
#listowanie aktywnych API
gcloud services list --enabled
#listowanie VMek
gcloud compute instances list
#listowanie dyskow
gcloud compute disks list
#listowanie VPC
gcloud compute networks list
#listowanie klastrow Kubernetes
gcloud container clusters list
#listowanie sql
gcloud sql instances list
#listowanie app engine
gcloud app services list
```

# ************************************FIREWALL RULES***********************************
```
gcloud compute firewall-rules create gke-nodeport \
    --network=my-vpc \
    --allow=tcp:30080 \
    --direction=INGRESS \
    --source-ranges=0.0.0.0/0 \
    --priority=1000 \
    --description="Allow NodePort to GKE" \
    --target-tags=nodeport-gke
```
```
gcloud compute firewall-rules list
```
# ******************************************VM***************************************** 
```
gcloud compute instances list
gcloud compute instances describe INSTANCE_NAME --zone=ZONE #Opis instancji
```

# ******************************************GKE*****************************************
#PREREQUISUITE >>  
```
#INSTALL gke-gcloud-auth-plugin >> 
sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin

#GET kube/.config from google cloud
gcloud container clusters get-credentials <CLUSTER-NAME> --region <REGION> --project <PROJECT> #Dodanie konfiguracji do kube/config
```


# ************************************MANAGED INSTANCES**********************************
#TEMPLATKA
```
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
```

#INSTANCE GROUP BAZUJACA NA TEMPLATCE
```
gcloud compute instance-groups managed create NAME --template=my-template-v1 --size=1 --zone=us-central1-c
```
# SET AUTOSCALLING
```
gcloud compute instance-groups managed set-autoscaling NAME \
  --max-num-replicas=3 \
  --min-num-replicas=1 \
  --target-cpu-utilization=0.6 \
  --cool-down-period=90 \
  --zone=us-central1-c
```

#NEW TEMPLATE
```
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
```

#ROLLING UPDATE
```
gcloud compute instance-groups managed rolling-action start-update NAME \
    --version=template=my-template-v2 \
    --zone=us-central1-c
```



# **************************************VPC********************************************
#Tworzenie VPC, bgp-routing(regional lub global)(subnet-moode  custom lub auto)
```
gcloud compute networks create my-vpc \
  --subnet-mode=custom \
  --bgp-routing-mode=regional
```

#Dodanie podsieci VPC PUBLIC < to tylko zalozenie 
```
gcloud compute networks subnets create public-subnet \
  --network=my-vpc \
  --region=us-central1 \
  --range=10.0.1.0/24
```

#Dodanie podsieci VPC Private < to tylko zalozenie
```gcloud compute networks subnets create private-subnet \
  --network=my-vpc \
  --region=us-central1 \
  --range=10.0.2.0/24
```

#Dodanie firewall rule ssh 22 do my-vpc
```
gcloud compute firewall-rules create allow-ssh \
  --network my-vpc \
  --allow tcp:22 \
  --source-ranges 0.0.0.0/0 \
  --direction INGRESS \
  --priority 500
```


#Public traffic
#Utworz trase do Default Gateway
#Trasy sa globalne , musisz bazowac na TAGach
#Twoje instancje musza posiadac TAGi
```
gcloud compute routes create route-to-internet-for-subnet \
  --network=my-vpc \
  --destination-range=0.0.0.0/0 \
  --next-hop-gateway=default-internet-gateway \
  --tags=subnet-public
```

#Private traffic
#router
```
gcloud compute routers create my-router \
  --network=my-vpc
  --region=us-central1
```

#CloudNAT
```
gcloud compute routers nats create my-nat-config \
  --router=my-router \
  --auto-allocate-nat-external-ips \
  --nat-custom-subnet-ip-ranges=private-subnet \
  --region=us-central1
```
#open ssh to whole VPC>required to connect via Identity-Aware Proxy (IAP)
```
gcloud compute firewall-rules create allow-ssh-vpc-wide \
  --network=my-vpc \
  --allow=tcp:22 \
  --source-ranges=0.0.0.0/0 \
  --direction=INGRESS
```

#Use
#Prerequisuite >> VM in private subnet exists
```
gcloud compute ssh COMPUTE_ENGINE_NAME   --zone=us-central1-c   --tunnel-through-iap
```         
