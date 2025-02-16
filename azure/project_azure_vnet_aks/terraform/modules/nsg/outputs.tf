output "nsg_id" {
  description = "ID Network Security Group (NSG)"
  value       = azurerm_network_security_group.vm_nsg.id
}