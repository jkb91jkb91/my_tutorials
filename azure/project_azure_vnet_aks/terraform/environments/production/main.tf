#VNET
module "vnet" {
  source = "../../modules/vnet"

}

#Network Security Group
module "nsg" {
  source                  = "../../modules/nsg"
  resource_group_name     = module.vnet.resource_group_name
  resource_group_location = module.vnet.resource_group_location
}

# KUBERNETES
module "aks" {
  source                  = "../../modules/aks"
  private_subnet_id       = module.vnet.private_subnet_id
  resource_group_name     = module.vnet.resource_group_name
  resource_group_location = module.vnet.resource_group_location
}

#JUMP HOST
module "jumpHostPublicVM" {
  source                    = "../../modules/virtualMachines"
  resource_group_name       = module.vnet.resource_group_name
  resource_group_location   = module.vnet.resource_group_location
  private_subnet_id         = module.vnet.public_subnet_id
  network_security_group_id = module.nsg.nsg_id
  aks_id                    = module.aks.aks_id
}

#Account Storage Container
# module "container" {
#   source                    = "../../modules/storageAccount"
#   resource_group_name       = module.vnet.resource_group_name
#   resource_group_location   = module.vnet.resource_group_location
# }

# #Data Factory
# module "adf" {
#   source                    = "../../modules/dataFactory"
#   resource_group_name       = module.vnet.resource_group_name
#   resource_group_location   = module.vnet.resource_group_location
# }


