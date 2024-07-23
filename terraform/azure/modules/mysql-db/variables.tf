
variable "resource_group_name" {
  description = "The name of the resource group."
  default     = "sample-resource-group"
  type        = string
}

variable "location" {
  description = "The location for all Azure resources."
  default     = "Central India"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  default     = "my-vnet"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network."
  default     = ["10.0.0.0/16"]
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet."
  default     = "my-subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet."
  default     = ["10.0.2.0/24"]
  type        = list(string)
}

variable "subnet_service_endpoints" {
  description = "Service endpoints for the subnet."
  default     = ["Microsoft.Storage"]
  type        = list(string)
}

variable "subnet_delegation_name" {
  description = "Name of the subnet delegation."
  default     = "test-delegation"
  type        = string
}

variable "subnet_service_delegation_name" {
  description = "Service delegation name for the subnet."
  default     = "Microsoft.DBforMySQL/flexibleServers"
  type        = string
}

variable "subnet_service_delegation_actions" {
  description = "Actions allowed for the subnet service delegation."
  default     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
  type        = list(string)
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone."
  default     = "test.mysql.database.azure.com"
  type        = string
}

variable "private_dns_zone_link_name" {
  description = "The name of the virtual network link to the private DNS zone."
  default     = "sampleVnetZone.com"
  type        = string
}

variable "mysql_server_name" {
  description = "The name of the MySQL flexible server."
  default     = "samplesqlserver02"
  type        = string
}

variable "mysql_admin_login" {
  description = "Administrator login for the MySQL server."
  default     = "mysqladmin"
  type        = string
}

variable "mysql_admin_password" {
  description = "Administrator password for the MySQL server."
  default     = "Password@123"
  type        = string
}

variable "mysql_backup_retention_days" {
  description = "Backup retention days for the MySQL server."
  default     = 7
  type        = number
}

variable "mysql_sku_name" {
  description = "SKU name for the MySQL server."
  default     = "B_Standard_B1s"
  type        = string
}

variable "mysql_zone" {
  description = "Availability zone for the MySQL server."
  default     = "2"
  type        = string
}

variable "mysql_database_name" {
  description = "The name of the MySQL database."
  default     = "sample-mysql-db"
  type        = string
}

variable "mysql_database_charset" {
  description = "Character set for the MySQL database."
  default     = "utf8"
  type        = string
}

variable "mysql_database_collation" {
  description = "Collation for the MySQL database."
  default     = "utf8_general_ci"
  type        = string
}

variable "mysql_firewall_rule_name" {
  description = "Name of the firewall rule for the MySQL server."
  default     = "AllowMyIP"
  type        = string
}

variable "mysql_firewall_start_ip" {
  description = "Start IP address for the MySQL firewall rule."
  default     = "192.168.1.1"
  type        = string
}

variable "mysql_firewall_end_ip" {
  description = "End IP address for the MySQL firewall rule."
  default     = "192.168.1.10"
  type        = string
}
