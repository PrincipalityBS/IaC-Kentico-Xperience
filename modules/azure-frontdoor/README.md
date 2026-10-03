# azure-frontdoor

Provisions an Azure Front Door (CDN) profile, endpoint, origin group, origin, and routing rule.

## Usage

```hcl
module "frontdoor" {
  source = "../../modules/azure-frontdoor"

  resource_group_name          = "rg-prod-fd"
  front_door_profile_name      = "fd-prod-app"
  front_door_sku_name          = "Standard_AzureFrontDoor"
  front_door_endpoint_name     = "fd-prod-endpoint"
  front_door_origin_group_name = "fd-prod-og"
  front_door_origin_name       = "fd-prod-origin"
  front_door_route_name        = "fd-prod-route"
  default_hostname             = module.app_service.default_hostname
}
```

## Inputs and Outputs

Inputs and outputs are automatically documented from `variables.tf` and `outputs.tf`.
