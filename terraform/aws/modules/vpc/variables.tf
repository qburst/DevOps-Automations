variable "name_prefix" {
  type    = string
  default = "common"
}

variable "ipv4_primary_cidr_block" {
  type    = string
  default = null
}

variable "ipv4_additional_cidr_block_associations" {
  type    = list(string)
  default = []
}

variable "instance_tenancy" {
  type    = string
  default = "default"
  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "Instance tenancy must be one of \"default\", \"dedicated\", or \"host\"."
  }
}

variable "dns_hostnames_enabled" {
  type    = bool
  default = true
}

variable "dns_support_enabled" {
  type    = bool
  default = true
}

variable "private_subnets_cidr" {
  type    = list(string)
  default = []
}

variable "public_subnets_cidr" {
  type    = list(string)
  default = []
}

variable "availability_zones" {
  type        = list(string)
  description = "the various AZs in which to create subnets"
  default     = []
}

variable "nat_gw_enabled" {
  type    = bool
  default = true
}
