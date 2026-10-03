mock_provider "azurerm" {}

run "database_has_correct_name_and_license" {
  command = plan

  variables {
    resource_group_name           = "rg-test-db"
    location                      = "uksouth"
    tags                          = { Environment = "test" }
    mssql_server_name             = "sql-test-server"
    mssql_server_version          = "12.0"
    mssql_server_administrator    = "testadmin"
    mssql_server_password         = "Test@Password123!"
    mssql_database_name           = "TestDB"
    mssql_database_collation      = "SQL_Latin1_General_CP1_CI_AS"
    mssql_database_license        = "LicenseIncluded"
    mssql_database_max_size_gb    = 10
    mssql_database_read_scale     = false
    mssql_database_sku_name       = "S3"
    mssql_database_zone_redundant = false
    mssql_database_enclave_type   = "VBS"
  }

  assert {
    condition     = azurerm_mssql_database.main.name == "TestDB"
    error_message = "Database name must match the input variable."
  }

  assert {
    condition     = azurerm_mssql_database.main.license_type == "LicenseIncluded"
    error_message = "Database license type must match the input variable."
  }
}

run "invalid_license_type_is_rejected" {
  command = plan

  variables {
    resource_group_name           = "rg-test-db"
    location                      = "uksouth"
    tags                          = {}
    mssql_server_name             = "sql-test-server"
    mssql_server_version          = "12.0"
    mssql_server_administrator    = "testadmin"
    mssql_server_password         = "Test@Password123!"
    mssql_database_name           = "TestDB"
    mssql_database_collation      = "SQL_Latin1_General_CP1_CI_AS"
    mssql_database_license        = "InvalidLicense"
    mssql_database_max_size_gb    = 10
    mssql_database_read_scale     = false
    mssql_database_sku_name       = "S3"
    mssql_database_zone_redundant = false
    mssql_database_enclave_type   = "VBS"
  }

  expect_failures = [var.mssql_database_license]
}
