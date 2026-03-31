

provider "azurerm" {
  features {}
}

# Module for network
module "network" {
  source                  = "../vnet"
  vnet_name               = var.vnet_name
  address_space           = var.vnet_address_space
  location                = var.location
  resource_group_name     = var.resource_group_name
  subnet_names            = var.subnet_names
  subnet_address_prefixes = var.subnet_address_prefixes
  nsg_name                = var.nsg_name
  inbound_rules           = var.inbound_rules
  outbound_rules          = var.outbound_rules
  environment             = var.environment
}

resource "azurerm_private_dns_zone" "domain" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vlink" {
  name                  = var.private_dns_zone_link_name
  private_dns_zone_name = azurerm_private_dns_zone.domain.name
  virtual_network_id    = module.network.vnet_id
  resource_group_name   = var.resource_group_name
}

resource "azurerm_mysql_flexible_server" "sqlserver" {
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.mysql_admin_login
  administrator_password = var.mysql_admin_password
  backup_retention_days  = var.mysql_backup_retention_days
  delegated_subnet_id    = module.network.subnet_ids[0] # Using the first subnet ID
  private_dns_zone_id    = azurerm_private_dns_zone.domain.id
  sku_name               = var.mysql_sku_name
  zone                   = var.mysql_zone

  depends_on = [azurerm_private_dns_zone_virtual_network_link.vlink]
}

resource "azurerm_mysql_flexible_database" "sqldb" {
  name                = var.mysql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.sqlserver.name
  charset             = var.mysql_database_charset
  collation           = var.mysql_database_collation
}

resource "azurerm_mysql_flexible_server_firewall_rule" "firewall" {
  name                = var.mysql_firewall_rule_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.sqlserver.name
  start_ip_address    = var.mysql_firewall_start_ip
  end_ip_address      = var.mysql_firewall_end_ip
}

# Private Endpoint
resource "azurerm_private_endpoint" "mysql_private_endpoint" {
  name                = var.mysql_private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_ids[0] # Using the first subnet ID

  private_service_connection {
    name                           = var.mysql_private_endpoint_connection_name
    private_connection_resource_id = azurerm_mysql_flexible_server.sqlserver.id
    subresource_names              = ["mysqlserver"]
    is_manual_connection           = false
  }
}
