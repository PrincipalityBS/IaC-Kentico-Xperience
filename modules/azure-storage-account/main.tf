terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
}

resource "azurerm_storage_account" "main" {
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  account_kind                  = "StorageV2"
  https_traffic_only_enabled    = true
  min_tls_version               = "TLS1_2"
  allow_nested_items_to_be_public = false
  # Disable shared key access once managed identity is confirmed working
  shared_access_key_enabled     = var.shared_access_key_enabled
  tags                          = var.tags

  blob_properties {
    versioning_enabled = false
  }

  lifecycle {
    ignore_changes = [
      tags["MG-Environment"], tags["MG-Service"]
    ]
  }
}

resource "azurerm_storage_container" "main" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}

# Grant the managed identity Storage Blob Data Owner on this account
resource "azurerm_role_assignment" "blob_data_owner" {
  count                = var.managed_identity_principal_id != null ? 1 : 0
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = var.managed_identity_principal_id
}
