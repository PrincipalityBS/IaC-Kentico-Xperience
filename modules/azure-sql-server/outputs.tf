output "server_id" {
  description = "Resource ID of the MSSQL server"
  value = azurerm_mssql_server.main.id
}

output "server_name" {
  description = "Name of the MSSQL server"
  value = azurerm_mssql_server.main.name
}

output "server_fqdn" {
  description = "Fully qualified domain name of the MSSQL server"
  value = azurerm_mssql_server.main.fully_qualified_domain_name
}
