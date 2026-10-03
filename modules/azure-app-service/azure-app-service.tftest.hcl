mock_provider "azurerm" {}

run "service_plan_has_correct_name_and_sku" {
  command = plan

  variables {
    resource_group         = "rg-test-app"
    location               = "uksouth"
    tags                   = { Environment = "test" }
    serviceplan_name       = "splan-test-web"
    serviceplan_sku        = "P1v3"
    serviceplan_os         = "Windows"
    app_name               = "app-test-web"
    network_resource_group = "rg-test-vnet"
    virtual_network_name   = "vnet-test"
    subnet_name            = "snet-test-app"
    ip_address_default_action  = "Deny"
    ip_restriction_action      = "Allow"
    ip_restriction_ip_address  = "10.0.0.0/8"
    ip_restriction_priority    = 100
    ip_restriction_name        = "Allow Internal"
  }

  assert {
    condition     = azurerm_service_plan.main.name == "splan-test-web"
    error_message = "Service plan name must match the input variable."
  }

  assert {
    condition     = azurerm_service_plan.main.sku_name == "P1v3"
    error_message = "Service plan SKU must match the input variable."
  }

  assert {
    condition     = azurerm_windows_web_app.main.name == "app-test-web"
    error_message = "Web app name must match the input variable."
  }

  assert {
    condition     = azurerm_windows_web_app.main.https_only == true
    error_message = "https_only must always be true."
  }
}

run "invalid_os_type_is_rejected" {
  command = plan

  variables {
    resource_group         = "rg-test-app"
    location               = "uksouth"
    tags                   = {}
    serviceplan_name       = "splan-test-web"
    serviceplan_sku        = "P1v3"
    serviceplan_os         = "MacOS"
    app_name               = "app-test-web"
    network_resource_group = "rg-test-vnet"
    virtual_network_name   = "vnet-test"
    subnet_name            = "snet-test-app"
    ip_address_default_action  = "Deny"
    ip_restriction_action      = "Allow"
    ip_restriction_ip_address  = "10.0.0.0/8"
    ip_restriction_priority    = 100
    ip_restriction_name        = "Allow Internal"
  }

  expect_failures = [var.serviceplan_os]
}
