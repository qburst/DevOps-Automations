variable "vm_name" {
  description = "Name of the virtual machine"
}

variable "location" {
  description = "Azure region"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
}

variable "subnet_id" {
  description = "ID of the subnet"
}

variable "virtual_network_name" {
  description = "Name of the Virtual Network"
}

variable "vm_size" {
  description = "Size of the virtual machine"
}

variable "admin_username" {
  description = "Admin username for the VM"
}

variable "admin_password" {
  description = "Admin password for the VM"
}

variable "tags" {
  description = "Tags for the VM"
}
