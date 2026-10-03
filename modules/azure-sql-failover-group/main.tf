terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
}

resource "azurerm_mssql_failover_group" "main" {
  name      = var.failover_group_name
  server_id = var.primary_server_id
  databases = var.database_ids

  partner_server {
    id = var.secondary_server_id
  }

  readonly_endpoint_failover_policy {
    mode = "Enabled"
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = var.grace_minutes
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags["MG-Environment"], tags["MG-Service"]
    ]
  }
}
