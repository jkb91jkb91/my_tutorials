# DESCRIPTION

0.) Run commands  
1.) Tree  
2.) ./terraform.tfvars HIGHEST LEVEL  
3.) From where load modules  

# 0. RUN COMMANDS  
a) 
```
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
│   │   └── terraform.tfvars
│   ├── staging
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
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
├── terraform.tfvars
├── variables.tf
├── outputs.tf
└── backend.tf
```
# 2. ./terraform.tfvars
a) Terraform provider  
b) Google project information  
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
  credentials ="~/.sa_bartek_gowno_project"
}
```

# 3. From where load modules
a) ./environments/production/main.tf
b) ./environments/staging/main.tf

```
module "compute_instance" {
  source        = "../../modules/compute"  # Ścieżka do modułu
  instance_name = "my-vm-instance"
  machine_type  = "e2-micro-1"
  zone          = "us-central1-a"
  disk_image    = "debian-cloud/debian-9"
  network       = "default"
  tags          = ["web", "dev"]
}
```

