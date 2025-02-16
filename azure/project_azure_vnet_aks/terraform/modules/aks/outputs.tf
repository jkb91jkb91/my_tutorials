
output "aks_id" {
  description = "ID klastra AKS"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_connect_command" {
  value = "az aks get-credentials --resource-group my-resource-group --name my-aks-cluster"
}
