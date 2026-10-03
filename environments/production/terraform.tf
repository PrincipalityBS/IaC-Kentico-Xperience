terraform {
  required_version = "~> 1.15"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # Run `terraform init -upgrade` to resolve and lock an exact version in .terraform.lock.hcl
      version = "~> 5.0"
    }
  }
}
