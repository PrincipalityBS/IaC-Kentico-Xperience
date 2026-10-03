# azure-search-service

Provisions an Azure Cognitive Search service.

## Usage

```hcl
module "search_service" {
  source = "../../modules/azure-search-service"

  resource_group_name                          = "rg-prod-search"
  location                                     = "uksouth"
  tags                                         = { Environment = "production" }
  search_service_name                          = "as-prod-search"
  search_service_sku                           = "standard"
  search_service_public_network_access_enabled = false
}
```

## Inputs and Outputs

Inputs and outputs are automatically documented from `variables.tf` and `outputs.tf`.
