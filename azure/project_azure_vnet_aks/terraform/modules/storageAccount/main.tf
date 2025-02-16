resource "azurerm_storage_account" "storage" {
  name                     = "storagecsv1148"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "data-input"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# output "storage_account_name" {
#   value = azurerm_storage_account.storage.name
# }

# output "container_name" {
#   value = azurerm_storage_container.container.name
# }


#