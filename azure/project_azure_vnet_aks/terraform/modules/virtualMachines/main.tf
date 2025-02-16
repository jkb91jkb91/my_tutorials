
# Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "vm-public-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"  # Lub "Dynamic"
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm-ip-config"
    subnet_id                     = var.private_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "vm_nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.network_security_group_id
}

# VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-instance"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = "Standard_B2s"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("/home/jkb91/.ssh/id_rsa.pub")
  }

  identity {
    type = "SystemAssigned"  # Dodaje System-Assigned Managed Identity
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  custom_data = base64encode(file("${path.module}/init-script.sh"))

   source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
    }
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "vm_contributor" {
  scope                = azurerm_linux_virtual_machine.vm.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

resource "azurerm_role_assignment" "aks_cluster_user" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

# resource "azurerm_role_assignment" "aks_role" {
#   scope                = var.aks_id
#   role_definition_name = "Azure Kubernetes Service Cluster User Role"
#   principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id
# }

#TO DO MUSISZ DODAC JESZCZE SUBSCIRPTION READER >>  Virtual Machine Contributor
#TO DO MUSISZ DODAC JESZCZE SUBSCIRPTION READER >>  Azure Kubernetes Service Cluster User Role



#TO DO MUSISZ DODAC JESZCZE SUBSCIRPTION READER >>  Storage Blob Data Contributor

# az storage blob upload  --account-name "storagecsv1148"  --container-name "data-input"  --file "shit.csv"  --name "sample.csv"  --auth-mode login
#az login --identity
#az aks get-credentials --resource-group vnet-rg --name my-private-aks