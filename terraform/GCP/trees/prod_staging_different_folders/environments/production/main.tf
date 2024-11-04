module "vpc" {
  source        = "../../modules/vpc"
}

# module "compute_instance" {
#   #MAPPING
#   #COMPUTE ENGINE NAMES = ACTUAL MODULE NAMES
#   source                = "../../modules/compute"  # Ścieżka do modułu
#   instance_name         = var.instance_name1
#   machine_type          = var.machine_type
#   zone                  = var.zone1
#   disk_image            = var.disk_image
#   network               = var.network
#   tags                  = var.tags
#   assign_public_ip      = var.assign_public_ip
# }

# module "compute_instance2" {
#   #MAPPING
#   #COMPUTE ENGINE NAMES = ACTUAL MODULE NAMES
#   source                = "../../modules/compute"  # Ścieżka do modułu
#   instance_name         = var.instance_name2
#   machine_type          = var.machine_type
#   zone                  = var.zone2
#   disk_image            = var.disk_image
#   network               = var.network
#   tags                  = var.tags
#   assign_public_ip      = var.assign_public_ip
# }

# module "umanaged-instance1" {
#   #MAPPING
#   #COMPUTE ENGINE NAMES = ACTUAL MODULE NAMES
#   source               = "../../modules/unmanaged_instance_group"
#   instances_self_link  = module.compute_instance.vm1_self_link
#   name                = var.group_name_1
#   zone                 = var.group_zone_1
# }

# module "umanaged-instance2" {
#   #MAPPING
#   #COMPUTE ENGINE NAMES = ACTUAL MODULE NAMES
#   source               = "../../modules/unmanaged_instance_group"
#   instances_self_link  = module.compute_instance2.vm1_self_link
#   name                = var.group_name_2
#   zone                 = var.group_zone_2
# }


# module "load-balancer" {
#   #MAPPING
#   #COMPUTE ENGINE NAMES = ACTUAL MODULE NAMES
#   source                     = "../../modules/loadbalancers/https-global-lb"
#   m_i_g_1 = module.umanaged-instance1.instance_group_self_link
#   m_i_g_2 = module.umanaged-instance2.instance_group_self_link
 
# }


# module "dashboard" {
#   source         = "../../modules/dashboard/dashboard-vm"
#   dashboard_name = var.d_name
# }

# module "dashboard-lb" {
#   #MAPPING
#   #LB MODULE NAMES = ACTUAL MODULE NAMES
#   source         = "../../modules/dashboard/dashboard-lb"
#   dashboard_name = var.d_lb_name
# }

module "gke" {
 source                          = "../../modules/gke"
 network_name                    = module.vpc.vpc_name
 subnetwork_id                   = module.vpc.subnetwork_id
 secondary_pods_ip_range_name    = module.vpc.secondary_pods_ip_range_name
 secondary_service_ip_range_name = module.vpc.secondary_service_ip_range_name
}

