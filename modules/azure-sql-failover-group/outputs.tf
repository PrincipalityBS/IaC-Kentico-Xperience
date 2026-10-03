output "failover_group_id" {
  description = "Resource ID of the SQL auto-failover group"
  value       = azurerm_mssql_failover_group.main.id
}

output "listener_endpoint" {
  description = "Read-write listener hostname — use this as the SQL Server in all app connection strings"
  value       = "${var.failover_group_name}.database.windows.net"
}

output "secondary_listener_endpoint" {
  description = "Read-only listener hostname pointing at the secondary (DR) replica"
  value       = "${var.failover_group_name}.secondary.database.windows.net"
}
