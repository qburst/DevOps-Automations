module "azure_vm" {
  source               = "../../modules/azure-vm"
  vm_name              = var.vm_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  subnet_id            = module.azurerm_subnet.subnet.id
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  tags                 = var.tags
}
