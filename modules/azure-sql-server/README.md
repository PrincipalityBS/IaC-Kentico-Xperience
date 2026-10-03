# azure-sql-server

Provisions an Azure MSSQL Server instance.

## Usage

```hcl
module "sql_server" {
  source = "../../modules/azure-sql-server"

  resource_group_name        = "rg-prod-db"
  location                   = "uksouth"
  tags                       = { Environment = "production" }
  mssql_server_name          = "sql-prod-app"
  mssql_server_version       = "12.0"
  mssql_server_administrator = "sqladmin"
  mssql_server_password      = var.db_password
}
```

## Inputs and Outputs

Inputs and outputs are automatically documented from `variables.tf` and `outputs.tf`.
