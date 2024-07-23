

provider "azurerm" {
  features {}
}

module "mysql_flexible_db" {
source = "./Modules/mysql_flexible_db"

# Add all required variables for the module
vnet_name                          = "my-vnet"
vnet_address_space                 = ["10.0.0.0/16"]
location                           = "Central India"
resource_group_name                = "sample-resource-group"
subnet_name                        = "test-subnet"
subnet_address_prefixes            = ["10.0.1.0/24", "10.0.2.0/24"]
nsg_name                           = "my-nsg"


inbound_rules = [
  {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

outbound_rules = [
  {
    name                       = "allow_all"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

  subnet_service_endpoints           = ["Microsoft.Storage"]
  subnet_delegation_name             = "test-delegation"
  subnet_service_delegation_name     = "Microsoft.DBforMySQL/flexibleServers"
  subnet_service_delegation_actions  = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
  private_dns_zone_name              = "test.mysql.database.azure.com"
  private_dns_zone_link_name         = "sampleVnetZone.com"
  mysql_server_name                  = "samplesqlserver02"
  mysql_admin_login                  = "mysqladmin"
  mysql_admin_password               = "Password@123"
  mysql_backup_retention_days        = 7
  mysql_sku_name                     = "B_Standard_B1s"
  mysql_zone                         = "2"
  mysql_database_name                = "sample-mysql-db"
  mysql_database_charset             = "utf8"
  mysql_database_collation           = "utf8_general_ci"
   environment                       = "dev"
  mysql_firewall_rules = [
    {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    },
    {
      name             = "AllowMyIP"
      start_ip_address = "123.456.789.0"
      end_ip_address   = "123.456.789.0"
    }
  ]
}
 
