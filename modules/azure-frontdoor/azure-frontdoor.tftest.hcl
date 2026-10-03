mock_provider "azurerm" {}

run "frontdoor_profile_has_correct_name_and_sku" {
  command = plan

  variables {
    resource_group_name          = "rg-test-fd"
    front_door_profile_name      = "fd-test-profile"
    front_door_sku_name          = "Standard_AzureFrontDoor"
    front_door_endpoint_name     = "fd-test-endpoint"
    front_door_origin_group_name = "fd-test-og"
    front_door_origin_name       = "fd-test-origin"
    front_door_route_name        = "fd-test-route"
    default_hostname             = "app-test.azurewebsites.net"
  }

  assert {
    condition     = azurerm_cdn_frontdoor_profile.main.name == "fd-test-profile"
    error_message = "Front Door profile name must match the input variable."
  }

  assert {
    condition     = azurerm_cdn_frontdoor_profile.main.sku_name == "Standard_AzureFrontDoor"
    error_message = "Front Door SKU must match the input variable."
  }
}

run "invalid_sku_is_rejected" {
  command = plan

  variables {
    resource_group_name          = "rg-test-fd"
    front_door_profile_name      = "fd-test-profile"
    front_door_sku_name          = "Basic_AzureFrontDoor"
    front_door_endpoint_name     = "fd-test-endpoint"
    front_door_origin_group_name = "fd-test-og"
    front_door_origin_name       = "fd-test-origin"
    front_door_route_name        = "fd-test-route"
    default_hostname             = "app-test.azurewebsites.net"
  }

  expect_failures = [var.front_door_sku_name]
}
