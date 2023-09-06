variable "vnet_name" {
  description = "Azure Virtual Network name"
  type        = string
  default     = "acctvnet"
}

variable "address_space" {
  description = "Address space for the Azure Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "location" {
  description = "Azure region where the resources will be created"
  type        = string
  default     = "South India"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-name"
}

variable "subnet_names" {
  description = "Names of the subnets"
  type        = list(string)
  default     = ["subnet1", "subnet2"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "aks_subnet_address_prefix" {
  description = "AKS Subnet Address Prefix"
  type        = string
  default     = null
}
 
variable "aks_subnet_address_name" {
  description = "AKS Subnet Name"
  type        = string
  default     = "aks-subnet"
}
 
variable "appgw_subnet_address_prefix" {
  description = "AppGW Subnet Address Prefix"
  type        = string
  default     = null
}
 
variable "appgw_subnet_address_name" {
  description = "AppGW Subnet Name"
  type        = string
  default     = "appgw-subnet"
}

variable "nnetwrok security group_name" {
  description = "Network Security Group name"
  type        = string
  default     = null
}

	
