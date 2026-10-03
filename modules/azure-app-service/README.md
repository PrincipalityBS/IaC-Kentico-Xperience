# azure-app-service

Provisions an Azure App Service Plan and a Windows Web App with VNet integration and IP restriction rules.

## Usage

```hcl
module "app_service" {
  source = "../../modules/azure-app-service"

  resource_group                     = "rg-prod-app"
  location                           = "uksouth"
  tags                               = { Environment = "production" }
  serviceplan_name                   = "splan-prod-web"
  serviceplan_sku                    = "P1v3"
  serviceplan_os                     = "Windows"
  serviceplan_zone_balancing_enabled = true
  serviceplan_workercount            = 3
  app_name                           = "app-prod-web"
  network_resource_group             = "rg-prod-vnet"
  virtual_network_name               = "vnet-prod"
  subnet_name                        = "snet-prod-app"
  ip_address_default_action          = "Deny"
  ip_restriction_action              = "Allow"
  ip_restriction_ip_address          = "10.0.0.0/8"
  ip_restriction_priority            = 100
  ip_restriction_name                = "Allow Internal"
}
```

## Inputs and Outputs

Inputs and outputs are automatically documented from `variables.tf` and `outputs.tf`.
