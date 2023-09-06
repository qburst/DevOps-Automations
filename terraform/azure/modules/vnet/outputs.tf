output "vnet_id" {
  description = "ID of the created Azure Virtual Network"
  value       = azurerm_virtual_network.Vnet.id
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = azurerm_subnet.subnets.*.id
}