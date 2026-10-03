terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>5.0"
    }
  }
}

resource "azurerm_search_service" "example" {
  name                          = var.search_service_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.search_service_sku
  tags                          = var.tags
  public_network_access_enabled = var.search_service_public_network_access_enabled
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
    tags["MG-Environment"],tags["MG-Service"]
    ]
  }
}