output "database_id" {
  description = "Resource ID of the MSSQL database"
  value = azurerm_mssql_database.main.id
}

output "database_name" {
  description = "Name of the MSSQL database"
  value = azurerm_mssql_database.main.name
}

output "server_id" {
  description = "Resource ID of the MSSQL server hosting the database"
  value = azurerm_mssql_server.main.id
}
