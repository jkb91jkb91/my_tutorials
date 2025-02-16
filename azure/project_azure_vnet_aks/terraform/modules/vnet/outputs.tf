output  resource_group_name {
  description = "Nazwa grupy zasobów"
  value       = azurerm_resource_group.rg.name
    
}
output resource_group_location {
  description = "Lokalizacja grupy zasobów"
  value       = azurerm_resource_group.rg.location

}
output private_subnet_id {
  description = "ID prywatnej podsieci"
  value       = azurerm_subnet.private_subnet.id
}

output public_subnet_id {
  description = "ID prywatnej podsieci"
  value       = azurerm_subnet.public_subnet.id
}