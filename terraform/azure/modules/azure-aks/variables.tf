variable "resource_group_name" {
  description = "Name of the Azure resource group."
}

variable "location" {
  description = "Azure region."
}

variable "cluster_name" {
  description = "Name for the AKS cluster."
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster."
}

variable "node_count" {
  description = "Number of nodes in the default node pool."
  default     = 1
}

variable "node_vm_size" {
  description = "Virtual machine size for nodes in the default node pool."
  default     = "Standard_D2_v2"
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
