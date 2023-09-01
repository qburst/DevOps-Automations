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
  default = "vm-size-name"
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

variable "tags" {
  description = "Tags for the VM"
  default = "development"
}
