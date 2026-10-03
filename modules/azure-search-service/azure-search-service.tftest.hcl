mock_provider "azurerm" {}

run "search_service_has_correct_name_and_sku" {
  command = plan

  variables {
    resource_group_name                          = "rg-test-search"
    location                                     = "uksouth"
    tags                                         = { Environment = "test" }
    search_service_name                          = "as-test-search"
    search_service_sku                           = "standard"
    search_service_public_network_access_enabled = false
  }

  assert {
    condition     = azurerm_search_service.example.name == "as-test-search"
    error_message = "Search service name must match the input variable."
  }

  assert {
    condition     = azurerm_search_service.example.sku == "standard"
    error_message = "Search service SKU must match the input variable."
  }

  assert {
    condition     = azurerm_search_service.example.public_network_access_enabled == false
    error_message = "Public network access flag must match the input variable."
  }
}

run "invalid_sku_is_rejected" {
  command = plan

  variables {
    resource_group_name                          = "rg-test-search"
    location                                     = "uksouth"
    tags                                         = {}
    search_service_name                          = "as-test-search"
    search_service_sku                           = "ultra"
    search_service_public_network_access_enabled = false
  }

  expect_failures = [var.search_service_sku]
}
