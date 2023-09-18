output "kube_config" {
  description = "Kubeconfig for accessing the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "cluster_name" {
  description = "Name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}
