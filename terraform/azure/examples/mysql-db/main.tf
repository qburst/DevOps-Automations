provider "azurerm" {
  features {}
}

module "azure_sql_db_flexible" {
  source = "./terraform-azure-sql-db-flexible"

  resource_group_name                = "sample-resource-group"
  location                           = "Central India"
  virtual_network_name               = "my-vnet"
  address_space                      = ["10.0.0.0/16"]
  subnet_name                        = "my-subnet"
  subnet_address_prefixes            = ["10.0.2.0/24"]
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

