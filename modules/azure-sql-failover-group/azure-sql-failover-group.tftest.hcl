mock_provider "azurerm" {}

run "failover_group_has_correct_name_and_mode" {
  command = plan

  variables {
    failover_group_name = "sqlf-test-app"
    primary_server_id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Sql/servers/sql-test-primary"
    secondary_server_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test-dr/providers/Microsoft.Sql/servers/sql-test-secondary"
    database_ids        = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Sql/servers/sql-test-primary/databases/TestDB"]
    grace_minutes       = 60
    tags                = {}
  }

  assert {
    condition     = azurerm_mssql_failover_group.main.name == "sqlf-test-app"
    error_message = "Failover group name must match the input variable."
  }

  assert {
    condition     = azurerm_mssql_failover_group.main.read_write_endpoint_failover_policy[0].mode == "Automatic"
    error_message = "Read-write failover policy mode must be Automatic."
  }

  assert {
    condition     = azurerm_mssql_failover_group.main.read_write_endpoint_failover_policy[0].grace_minutes == 60
    error_message = "Grace minutes must match the input variable."
  }
}

run "invalid_grace_minutes_is_rejected" {
  command = plan

  variables {
    failover_group_name = "sqlf-test-app"
    primary_server_id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Sql/servers/sql-test-primary"
    secondary_server_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test-dr/providers/Microsoft.Sql/servers/sql-test-secondary"
    database_ids        = []
    grace_minutes       = 99999
    tags                = {}
  }

  expect_failures = [var.grace_minutes]
}
