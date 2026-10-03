output "frontdoor_profile_id" {
  description = "Resource ID of the Front Door profile"
  value = azurerm_cdn_frontdoor_profile.main.id
}

output "frontdoor_endpoint_host_name" {
  description = "Host name of the Front Door endpoint"
  value = azurerm_cdn_frontdoor_endpoint.main.host_name
}
