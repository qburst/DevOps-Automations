
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  tags = var.tags
}

# Output the kube_config block
output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

# Output the cluster name
output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}