# azure-sql-database

Provisions an Azure MSSQL Server and Database together.

## Usage

```hcl
module "sql_database" {
  source = "../../modules/azure-sql-database"

  resource_group_name            = "rg-prod-db"
  location                       = "uksouth"
  tags                           = { Environment = "production" }
  mssql_server_name              = "sql-prod-app"
  mssql_server_version           = "12.0"
  mssql_server_administrator     = "sqladmin"
  mssql_server_password          = var.db_password
  mssql_database_name            = "AppDB"
  mssql_database_collation       = "SQL_Latin1_General_CP1_CI_AS"
  mssql_database_license         = "LicenseIncluded"
  mssql_database_max_size_gb     = 50
  mssql_database_read_scale      = false
  mssql_database_sku_name        = "P1"
  mssql_database_zone_redundant  = false
  mssql_database_enclave_type    = "VBS"
}
```

## Inputs and Outputs

Inputs and outputs are automatically documented from `variables.tf` and `outputs.tf`.
