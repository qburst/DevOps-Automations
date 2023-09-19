variable "vm_name" {
  description = "Name of the virtual machine"
  type = string
  default = "sample-vm"
}

variable "location" {
  description = "Azure region"
  type = string
  default = "South India"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type = string
  default = "rg-name"
}

variable "publisher" {
    description = "Name of the publisher OS"
    type = string
    default = "Canonical"
}

variable "offer" {
  description = "Name of the offer OS"
  type = string
  default = "UbuntuServer"
}

variable "sku" {
  description = "Name of the sku OS"
  type = string
  default = "20.04-LTS"
}

variable "version" {
  description = "Name of the OS version"
  type = string
  default = "latest"
}

variable "subnet_name" {
    description = "Name of the Subnet Name"
    type = string
    default ="internal"
}

variable "virtual_network_name" {
  description = "Name of the Virtual Network"
  type = string
  default = "vnet-name"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type = string
  default = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type = string
  default = "adminuser"
}

variable "admin_password" {
  description = "Admin password for the VM"
  default = "Password@123"
}

variable "allocation_method" {
  description = "Allocation method of a public ip"
  default = "Static"
}

variable "public_ip_name" {
  description = "Name of public ip"
  default = "publicIP-name"
}

variable "computer_name" {
  description = "Computer name of Os profile"
  default = "hostname"
}

variable "private_ip_address_allocation" {
  description = "Type of allocation"
  default = "Static"
}

variable "azurerm_network_interface_name" {
  description = "Name of NIC"
  default = "nic_name"
}

variable "ip_configuration" {
  description = "Name of the ip_configuration"
  default = "internal"
}

variable "managed_disk_type" {
  description = "Managed disk type storage os disk"
  default = "Standard_LRS"
}

variable "managed_disk_name" {
  description = "Managed disk name storage os disk"
  default = "disk-name"
}

variable "create_option" {
  description = "Create option type storage os disk"
  default = "FromImage"
}

variable "create_option_disk" {
  description = "Create option disk type storage os disk"
  default = "Empty"
}

variable "disk_size_gb" {
  description = "Size of a Extra Disk"
  default = "10"
}

variable "caching" {
  description = "Caching for storage os disk"
  default = "ReadWrite"
}

variable "lun" {
  description = "Logic unit numbers for shared storage"
  type = number
  default = 2
}

variable "storage_os_disk_name" {
  description = "Name of the storage os disk"
  default = "myosdisk1"
}

variable "tags" {
  description = "Tags for the VM"
  default = "development"
}
