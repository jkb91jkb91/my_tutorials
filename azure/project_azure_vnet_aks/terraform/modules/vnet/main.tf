
resource "azurerm_resource_group" "rg" {
  name     = "vnet-rg"
  location = "West US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "public-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "private-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}


# Utworzenie grupy zasobów
#resource "azurerm_resource_group" "example" {
#  name     = "rg-databricks"
#  location = "Wast US"
#}

# resource "azurerm_databricks_workspace" "example" {
#   name                     = "myworkspace"

#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   sku                       = "standard"
  
#   tags = {
#     Environment = "Production"
#   }


#   depends_on = [
#     azurerm_virtual_network.vnet,
#     azurerm_subnet.public_subnet,
#     azurerm_subnet.private_subnet
#   ]
# }


# resource "azurerm_nat_gateway" "natgw" {
#   name                = "my-nat-gateway"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   sku_name            = "Standard"
# }

# resource "azurerm_public_ip" "natgw_pip" {
#   name                = "my-nat-gateway-pip"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   allocation_method   = "Static"
#   sku                = "Standard"
# }

# resource "azurerm_nat_gateway_public_ip_association" "natgw_assoc" {
#   nat_gateway_id       = azurerm_nat_gateway.natgw.id
#   public_ip_address_id = azurerm_public_ip.natgw_pip.id
# }

# resource "azurerm_subnet_nat_gateway_association" "aks_natgw_assoc" {
#   subnet_id      = azurerm_subnet.private_subnet.id
#   nat_gateway_id = azurerm_nat_gateway.natgw.id
# }

# resource "azurerm_route_table" "aks_rt" {
#   name                = "aks-route-table"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   route {
#     name                   = "default-route"
#     address_prefix         = "0.0.0.0/0"
#     next_hop_type          = "VirtualAppliance"  # NAT Gateway
#     next_hop_in_ip_address = azurerm_nat_gateway.natgw.id  # 🔹 Adres IP NAT Gateway
#   }
# }

# resource "azurerm_subnet_route_table_association" "aks_rt_assoc" {
#   subnet_id      = azurerm_subnet.private_subnet.id
#   route_table_id = azurerm_route_table.aks_rt.id
# }
