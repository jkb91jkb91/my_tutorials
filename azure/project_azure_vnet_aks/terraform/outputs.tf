output "aks_connect_command" {
  description = "Command to connect to the AKS cluster"
  value       = module.aks.aks_connect_command
}
