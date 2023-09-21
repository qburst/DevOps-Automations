

module "az-vm" {

  source                 = "./modules/az-vm"
  resource_group_name    = var.resource_group_name
  location               = var.location
  subnet_name            = var.subnet_name
  virtual_network_name   = var.virtual_network_name
  network_interface_name = var.network_interface_name
  vm_name                = var.vm_name
  vm_size                = var.vm_size
  ip_config              = var.ip_config
  address_allocation     = var.address_allocation
  public_ip              = var.public_ip
  publisher              = var.publisher
  offer                  = var.offer
  sku                    = var.sku
  image_version          = var.image_version
  os_disk_name           = var.os_disk_name
  create_option          = var.create_option
  computer_name          = var.computer_name
  admin_username         = var.admin_username
  admin_password         = var.admin_password
  allocation_method      = var.allocation_method
  managed_disk_type      = var.managed_disk_type
  create_option_disk     = var.create_option_disk
  disk_size_gb           = var.disk_size_gb
  lun                    = var.lun
  caching_disk           = var.caching_disk
  environment            = var.environment
}