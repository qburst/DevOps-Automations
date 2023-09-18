
resource "azurerm_resource_group" "rg-vm" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vn-vm" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = var.azurerm_network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_virtual_machine" "vm-sample" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]
  depends_on = [ azurerm_public_ip.public_ip ]


  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version
  }

  storage_os_disk {
    name              = var.storage_os_disk_name
    caching           = var.caching
    create_option     = var.create_option
    managed_disk_type = var.managed_disk_type
  }

  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method

}


