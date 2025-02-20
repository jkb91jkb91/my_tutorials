# DETAILS
0.) .gitignore  
1.) DIFFFERENT ENVIRONMENTS WITHOUT WORKSPACES   
  a) staging/terraform.tfvars  
  b) production/terraform.tfvars  
2.) ONE ENV WITH USING WORKSPACES  
  a) main.tf   
X) backend  


#0 .gitignore
```
terraform.tfstate
terraform.tfstate.backup
.terraform/
*.tfplan
*.tfvars
crash.log
*.log
.terraform.rc
output.log  
plan.out  
*.backup  
*.bak  
```

#1 DIFFERENT ENVIRONMENT WITHOUT WORKSPACES

1.IF your staging and production is quite different you can use such structure  
File: terraform.tfvars is different for every env  

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
│   ├── gke
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── compute
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── vpc
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
a) staging/terraform.tvfars  

```
project_id = "my-staging-project"
region     = "us-central1"
instance_type = "e2-medium"

```
b) production/terraform.tfvars

DIFFERENT PROJECT FOR PRODUCTI

```
project_id = "my-production-project"
region     = "us-central1"
instance_type = "n2-standard-4" 
```

#2 ONE ENV WITH USING WORKSPACES
If your structure is similar/same, you dont need to have seperate folders for envs  


```
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars  (opcjonalnie, dla wspólnych zmiennych)
├── modules
│   ├── gke
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── compute
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── vpc
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
├── backend.tf
```
a) provider.tf

```
provider "google" {
  project = var.project_id
  region  = var.region
}
```

b) main.tf
```
# Dynamiczne zmienne dla workspace'a
locals {
  project_id    = terraform.workspace == "production" ? "my-production-project" : "my-staging-project"
  region        = terraform.workspace == "production" ? "us-central1" : "us-east1"
  instance_type = terraform.workspace == "production" ? "n2-standard-4" : "e2-medium"
  node_count    = terraform.workspace == "production" ? 5 : 2
}

# Wywołanie modułu VPC
module "vpc" {
  source = "./modules/vpc"
  
  project_id = local.project_id
  region     = local.region
}

# Wywołanie modułu Compute Engine
module "compute" {
  source = "./modules/compute"
  
  project_id    = local.project_id
  region        = local.region
  instance_type = local.instance_type
}

# Wywołanie modułu GKE
module "gke" {
  source = "./modules/gke"
  
  project_id = local.project_id
  region     = local.region
  node_count = local.node_count
}

# Wywołanie modułu Firewall
module "firewall" {
  source = "./modules/firewall"
  
  project_id = local.project_id
  region     = local.region
}
```

# BACKEND
