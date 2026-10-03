mock_provider "azurerm" {}

run "sql_server_has_correct_name_and_version" {
  command = plan

  variables {
    resource_group_name        = "rg-test-db"
    location                   = "uksouth"
    tags                       = { Environment = "test" }
    mssql_server_name          = "sql-test-server"
    mssql_server_version       = "12.0"
    mssql_server_administrator = "testadmin"
    mssql_server_password      = "Test@Password123!"
  }

  assert {
    condition     = azurerm_mssql_server.main.name == "sql-test-server"
    error_message = "Server name must match the input variable."
  }

  assert {
    condition     = azurerm_mssql_server.main.version == "12.0"
    error_message = "Server version must match the input variable."
  }

  assert {
    condition     = azurerm_mssql_server.main.administrator_login == "testadmin"
    error_message = "Administrator login must match the input variable."
  }
}

run "invalid_server_version_is_rejected" {
  command = plan

  variables {
    resource_group_name        = "rg-test-db"
    location                   = "uksouth"
    tags                       = {}
    mssql_server_name          = "sql-test-server"
    mssql_server_version       = "99.0"
    mssql_server_administrator = "testadmin"
    mssql_server_password      = "Test@Password123!"
  }

  expect_failures = [var.mssql_server_version]
}
