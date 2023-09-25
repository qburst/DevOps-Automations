
variable "location" {
  description = "Location"
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Resource name"
  default     = "john-qb-rg"
}

variable "virtual_network_name" {
  description = "Name of the Virtual network"
  default     = "john-qb-vn"
}

variable "network_interface_name" {
  description = "Name of the Network Interface"
  default     = "john-qb-nic"
}

variable "subnet_name" {
  description = "Name of the subnet"
  default     = "john-qb-subnet"
}

variable "vm_name" {
  description = "Name of the VM"
  default     = "john-qb-vm"
}

variable "ip_config" {
  description = "Name of the Ip config"
  default     = "testconfiguration1"
}

variable "vm_size" {
  description = "Size of a vm"
  default     = "Standard_DS1_v2"
}

variable "public_ip" {
  description = "Public ip"
  default     = "john-qb-pub-ip"
}

variable "publisher" {
  description = "Publisher of the image"
  default     = "Canonical"
}

variable "offer" {
  description = "Image variant"
  default     = "0001-com-ubuntu-server-focal"
}

variable "sku" {
  description = "Image sku"
  default     = "20_04-lts"
}

variable "image_version" {
  description = "Image version"
  default     = "latest"
}

variable "os_disk_name" {
  description = "name of the os"
  default     = "myosdisk1"
}

variable "create_option" {
  description = "Image create option"
  default     = "FromImage"
}

variable "computer_name" {
  description = "Name of the computer"
  default     = "hostname"
}

variable "admin_username" {
  description = "Username"
  default     = "testadmin"
}

variable "admin_password" {
  description = "Password"
  default     = "Password1234!"
}

variable "address_allocation" {
  description = "public ip allocation method"
  default     = "Dynamic"
}

variable "allocation_method" {
  description = "public ip allocation method"
  default     = "Static"
}

variable "managed_disk_type" {
  description = "Managed disk type storage os disk"
  default     = "Standard_LRS"
}

variable "managed_disk" {
  description = "Managed disk name storage os disk"
  default     = "disk-name"
}

variable "create_option_disk" {
  description = "Create option disk type storage os disk"
  default     = "Empty"
}

variable "disk_size_gb" {
  description = "Size of a Extra Disk"
  default     = "1024"
}

variable "lun" {
  description = "Logic unit numbers for shared storage"
  type        = number
  default     = 2
}

variable "caching_disk" {
  default = "ReadWrite"
}

variable "environment" {
  default = "dev"
}