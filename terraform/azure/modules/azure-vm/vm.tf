


resource "azurerm_resource_group" "vmrg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name


  depends_on = [azurerm_resource_group.vmrg]
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]


  depends_on = [azurerm_resource_group.vmrg]
}

resource "azurerm_network_interface" "main" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name


  depends_on = [azurerm_resource_group.vmrg]

  ip_configuration {
    name                          = var.ip_config
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.address_allocation
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size

  depends_on = [azurerm_resource_group.vmrg]

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }
  storage_os_disk {
    name              = var.os_disk_name
    caching           = var.caching_disk
    create_option     = var.create_option
    managed_disk_type = var.managed_disk_type
  }
  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method


  depends_on = [azurerm_resource_group.vmrg]
}

resource "azurerm_managed_disk" "data_disk" {
  name                 = var.managed_disk
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.managed_disk_type
  create_option        = var.create_option_disk
  disk_size_gb         = var.disk_size_gb

  depends_on = [azurerm_resource_group.vmrg]

}

resource "azurerm_virtual_machine_data_disk_attachment" "vm-data-disk-attach" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_virtual_machine.main.id
  lun                = var.lun
  caching            = var.caching_disk
}