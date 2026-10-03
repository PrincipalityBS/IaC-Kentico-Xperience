# azure-sql-failover-group

Provisions an Azure SQL Auto-Failover Group across a primary and secondary MSSQL server, enabling transparent geo-redundant failover with a single connection endpoint.

The failover group must be defined in the same Terraform state as the **primary** server. The secondary server is referenced by resource ID (typically via a data source lookup or cross-environment variable).

## Connection string

After provisioning, all applications should connect to the **read-write listener**:

```
Server=<failover_group_name>.database.windows.net;Database=<db_name>;...
```

DNS for this endpoint automatically redirects to whichever region is currently primary, so no application-side changes are required during a failover.

## Deployment order

1. Apply the **DR environment** first to ensure the secondary SQL server exists.
2. Apply the **production environment** — the failover group requires the secondary server to already be present.

## Usage

```hcl
data "azurerm_mssql_server" "secondary" {
  name                = "sql-dr-server"
  resource_group_name = "rg-dr-app"
}

module "sql_failover_group" {
  source = "../../modules/azure-sql-failover-group"

  tags                = { Environment = "production" }
  failover_group_name = "sqlf-prod-app"
  primary_server_id   = module.sql_database.server_id
  secondary_server_id = data.azurerm_mssql_server.secondary.id
  database_ids        = [module.sql_database.database_id]
  grace_minutes       = 60
}
```

## Inputs and Outputs

Inputs and outputs are automatically documented from `variables.tf` and `outputs.tf`.
