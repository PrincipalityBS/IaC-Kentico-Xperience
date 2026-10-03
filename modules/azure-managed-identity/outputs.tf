output "identity_id" {
  description = "Resource ID of the user-assigned managed identity — pass to App Service identity_ids"
  value       = azurerm_user_assigned_identity.main.id
}

output "principal_id" {
  description = "Principal ID — pass to storage account module for role assignment"
  value       = azurerm_user_assigned_identity.main.principal_id
}

output "client_id" {
  description = "Client ID of the managed identity — set as the credential in Kentico's managed identity configuration"
  value       = azurerm_user_assigned_identity.main.client_id
}
