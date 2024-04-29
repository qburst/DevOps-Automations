variable "vnet_name" {
  description = "Name of the Azure Virtual Network"
  default     = "testvnet"
  type        = string
}

variable "address_space" {
  description = "Address space for the Azure Virtual Network"
  default     = ["10.0.0.0/16"]
  type        = list(string)
}

variable "location" {
  description = "Azure region where the resources will be created"
  default     = "us-east-1"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "testrg"
  type        = string
}

variable "subnet_names" {
  description = "Names of the subnets"
  default     = ["testsubnet"]
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnets"
  default     = ["10.0.1.0/24"]
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of Security group"
  default     = "testnsg"
  type        = string
}

variable "inbound_rules" {
  description = "A map of inbound security rules"
  default = {
    rule1 = {
      name                       = "inbound_rule1"
      priority                   = 100
      access                     = "Allow"
      protocol                   = "TCP"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "1.2.3.4"
      destination_address_prefix = "10.0.1.0/24"
    }
  }
  type = map(object({
    name                       = string
    priority                   = number
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "outbound_rules" {
  description = "A map of outbound security rules"
  default = {
    rule1 = {
      name                       = "outbound_rule1"
      priority                   = 100
      access                     = "Allow"
      protocol                   = "TCP"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "5.6.7.8"
    }
  }
  type = map(object({
    name                       = string
    priority                   = number
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}
