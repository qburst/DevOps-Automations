variable "vnet_name" {
  description = "Name of the Azure Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the Azure Virtual Network"
  type        = list(string)
}

variable "location" {
  description = "Azure region where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "subnet_names" {
  description = "Names of the subnets"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnets"
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of Security group"
  type        = string
}

variable "inbound_rules" {
  description = "A map of inbound security rules"
  type        = map(object({
    name                        = string
    priority                    = number
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
  }))
}

variable "outbound_rules" {
  description = "A map of outbound security rules"
  type        = map(object({
    name                        = string
    priority                    = number
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
  }))
}