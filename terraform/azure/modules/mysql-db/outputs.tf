

output "mysql_server_fqdn" {
  value = azurerm_mysql_flexible_server.sqlserver.fqdn
}

output "mysql_database_id" {
  value = azurerm_mysql_flexible_database.sqldb.id
}
