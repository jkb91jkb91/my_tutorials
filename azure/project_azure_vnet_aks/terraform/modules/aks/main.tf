resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-private-aks"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 1  # 1 NODE
    vm_size    = "Standard_B2s"  #
    vnet_subnet_id = var.private_subnet_id
  }

  network_profile {
    network_plugin   = "azure"
    network_policy   = "azure"
    service_cidr     = "10.2.0.0/24"  # 🔹 254 adresy dla Services
    dns_service_ip   = "10.2.0.10"    # 🔹 CoreDNS musi mieć IP z service_cidr
    outbound_type     = "loadBalancer"
}

  private_cluster_enabled = true  # AKS PRIVAETE ENDPOINT ONLY

  identity {
    type = "SystemAssigned"  # 🔹 System-Assigned Managed Identity
  }

  oidc_issuer_enabled       = true   # REQUIRED for Workload Identity
  workload_identity_enabled = true   # REQUIRED for Workload Identity

  # TO DO 
  # 1 Add Privileges for Load Balancer creation >> Network Contributor(Public IP, LoadBalancer)

}


