
#Staging
#provider "google" {
#  project = "nowy-437906"
#  region = "us-central-1"
#  zone = "us-central1-a"
#  credentials ="/home/jkb91/.nowy_gcp.json"
#}



# provider "google" {
#  project = "gowno-439010"
# region = "us-central-1"
#  zone = "us-central1-a"
#  credentials ="/home/jkb91/.sa_bartek_gowno_project.json"
#}


provider "google" {
  project = var.project
  region = "us-central-1"
  zone = "us-central1-a"
  credentials = var.creds
}




module "vpc" {
  source        = "./modules/vpc"
  name          = var.vpc_name
}


# module "compute_instance" {
#   #MAPPING
#   #COMPUTE ENGINE NAMES = ACTUAL MODULE NAMES
#   source                = "./modules/compute"  # Ścieżka do modułu
#   instance_name         = var.instance_name1
#   machine_type          = var.machine_type
#   zone                  = var.zone1
#   disk_image            = var.disk_image
#   network               = var.network
#   tags                  = var.tags
#   assign_public_ip      = var.assign_public_ip
# }
