variable "subnets" {
  description = "Subnets configuration"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "vnet_name" {
  description = "Virtual network name"
}

variable "address_space" {
  description = "Vnet address space"
   type        = list(string)
}

variable "resource_group_name" {
  description = "RG"
}

variable "location" {
  description = "Location"
}