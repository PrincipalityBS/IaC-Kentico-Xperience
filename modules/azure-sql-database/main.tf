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

resource "azurerm_mssql_database" "main" {
  name                         = var.mssql_database_name
  server_id                    = azurerm_mssql_server.main.id
  collation                    = var.mssql_database_collation
  license_type                 = var.mssql_database_license
  max_size_gb                  = var.mssql_database_max_size_gb
  read_scale                   = var.mssql_database_read_scale
  sku_name                     = var.mssql_database_sku_name
  zone_redundant               = var.mssql_database_zone_redundant
  enclave_type                 = var.mssql_database_enclave_type
  tags                         = var.tags
    lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
    tags["MG-Environment"],tags["MG-Service"]
    ]
  }
}
