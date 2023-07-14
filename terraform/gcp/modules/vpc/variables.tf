variable "name_prefix" {
  type = string
  default = "common"
}


variable "subnet_config" {
  type = list(object({
    name                  = string
    subnet_region         = string
    subnet_ip_cidr_range  = string
    nat_gw_enabled        = optional(bool, false)
    nat_ip_allocate_option = optional(string, "AUTO_ONLY")
  }))
  default = null
}

