data "azurerm_subnet" "main" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.network_resource_group
}

output "integrationsubnet" {
  value = data.azurerm_subnet.main.id
}
