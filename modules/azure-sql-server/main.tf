terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>5.0"
    }
  }
}

resource "azurerm_mssql_server" "main" {
  name                         = var.mssql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.mssql_server_version
  administrator_login          = var.mssql_server_administrator
  administrator_login_password = var.mssql_server_password
  tags                         = var.tags
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
    tags["MG-Environment"],tags["MG-Service"]
    ]
  }
}
