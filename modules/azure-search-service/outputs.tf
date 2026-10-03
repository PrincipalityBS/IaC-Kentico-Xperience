output "search_service_id" {
  description = "Resource ID of the Azure Cognitive Search service"
  value = azurerm_search_service.example.id
}

output "search_service_name" {
  description = "Name of the Azure Cognitive Search service"
  value = azurerm_search_service.example.name
}
