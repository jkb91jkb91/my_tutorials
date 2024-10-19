a# TWO ENVIRONMENTS STAGING && PRODUCTION AND PROVIDERS ON EACH LEVEL

0.) Run commands  
1.) Tree   


# INFO
PROD provider    >> projectNAME GOWNO
STAGING provider >> projectNAME NOWY

PROD
-Project NOWY  
-CREDS gowno  
```
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.40.0"
    }
  }
}
provider "google" {
  project = "gowno-439010"
  region = "us-central-1"
  zone = "us-central1-a"
  credentials ="/home/jkb91/.sa_bartek_gowno_project.json"
```
STAGING >> 
-Project NOWY  
-CREDS gowno  
```
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.40.0"
    }
  }
}
provider "google" {
  project = "nowy-437906"
  region = "us-central-1"
  zone = "us-central1-a"
  credentials ="/home/jkb91/.sa_bartek_nowy_project.json"
```
# 0. RUN COMMANDS  FROM PROVIDER LOCATION LIKE: ENVIRONMENTS/PRODUCTION or ENVIRONEMTS/STAGING
INFO: You have to run terraform from the level where terraform provider is located  
a) 
```
cd environments/production && terraform init
cd environments/production && terraform init
```


b) 
```
terraform plan
```
Automatycznie bd szukal pliku terraform tf.vars, tak na prawde to komenda ktora uruchomi to terraform plan -var-file="terraform.tfvars"  
W ponizszej komendzie jesli bd chcial podac konkretny plik to w -var-file=production.tfvars mozesz podac  

 
c)
```
 terraform apply
```
Automatycznie bd szukal pliku terraform tf.vars, tak na prawde to komenda ktora uruchomi to terraform apply -var-file="terraform.tfvars"  
W ponizszej komendzie jesli bd chcial podac konkretny plik to w -var-file=production.tfvars mozesz podac 


# 2. Tree  
```
├── environments
│   ├── production
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── provider.tf
│   │   └── terraform.tfvars
│   ├── staging
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── provider.tf
│   │   └── terraform.tfvars
├── modules
│   ├── compute
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── firewall
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
```
