# IaC-Kentico-Xperience

Terraform Infrastructure as Code for deploying **Kentico Xperience** on Microsoft Azure.

## Overview

This repository provisions and manages Azure infrastructure for a Kentico Xperience deployment across three environments:

| Environment | Region | State file |
|---|---|---|
| `production` | UK South | `iac-kenticoxp/production.tfstate` |
| `disaster-recovery` | UK West | `iac-kenticoxp/disaster-recovery.tfstate` |
| `uat` | UK South | `iac-kenticoxp/uat.tfstate` |

Remote state is stored in an Azure Storage Account (`stkenticoxptfcinf`, container `terraformstate`, resource group `rg-p-tf-c-inf`).

## Architecture

Each environment provisions the following Azure resources:

| Module | Resource | Notes |
|---|---|---|
| `azure-resource-groups` | Resource Group | Logical container for all environment resources |
| `azure-app-service` | App Service Plan + Windows Web App | Deployed twice — main site and admin site |
| `azure-sql-server` *(DR only)* | MSSQL Server | DR uses server-only; no active database module |
| `azure-sql-database` *(prod + UAT)* | MSSQL Server + Database | Combined server and database provisioning |
| `azure-search-service` *(prod + UAT)* | Azure Cognitive Search | Smart search integration; commented out in DR |
| `azure-frontdoor` | Azure Front Door (CDN) | Provisioned separately; currently disabled in all environments |

### Split deployment pattern

This IaC follows the [Kentico Xperience split deployment](https://docs.kentico.com/documentation/developers-and-admins/deployment/deploy-to-private-cloud/deploy-without-the-administration) pattern:

- The **main site** runs without the `Kentico.Xperience.Admin` NuGet package, reducing attack surface and overhead for public traffic.
- The **admin site** carries the full admin package and is network-restricted (default Deny, `10.0.0.0/8` allow-only).
- **Both app services connect to the same SQL database.** This is a hard architectural constraint — do not provision separate databases per instance.
- Both app services must share the same Azure Storage Account connection string for consistent media and asset access.

## Repository structure

```
environments/
  disaster-recovery/
    backend.tf          # Remote state backend configuration
    main.tf             # Module calls
    providers.tf        # AzureRM provider configuration
    terraform.tf        # required_version and required_providers
    terraform.tfvars    # Environment-specific variable values
    variables.tf        # Input variable declarations
  production/           # Same layout as disaster-recovery
  uat/                  # Same layout as disaster-recovery
modules/
  azure-app-service/    # App Service Plan + Windows Web App
  azure-frontdoor/      # Azure Front Door profile, endpoint, origin, route
  azure-resource-groups/# Resource Group
  azure-search-service/ # Azure Cognitive Search service
  azure-sql-database/   # MSSQL Server + Database (combined)
  azure-sql-server/     # MSSQL Server only
```

Each module contains `main.tf`, `variables.tf`, `outputs.tf`, `README.md`, and a `*.tftest.hcl` test file.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) `~> 1.15`
- Azure CLI authenticated to the target subscription
- Access to the remote state storage account

## Usage

```bash
cd environments/<environment>

# First-time or after provider version changes
terraform init -upgrade

terraform plan
terraform apply
```

### Supplying the database password

`mssql_server_password` is a sensitive variable with no default. Supply it at runtime — never commit it:

```bash
terraform apply -var="mssql_server_password=<secret>"
```

Or export as an environment variable:

```bash
export TF_VAR_mssql_server_password="<secret>"
terraform apply
```

### Provider version pinning

The provider constraint is `~> 5.0`. After running `terraform init -upgrade`, the resolved version is recorded in `.terraform.lock.hcl`. Commit the lock file and, once a version is stable, tighten the constraint to the exact version (e.g. `version = "5.x.y"`).

## Running tests

Terraform native tests use `mock_provider` and require no live Azure credentials:

```bash
cd modules/<module-name>
terraform test
```

## References

- [Deploy to private cloud (Azure)](https://docs.kentico.com/documentation/developers-and-admins/deployment/deploy-to-private-cloud)
- [Deploy without the administration](https://docs.kentico.com/documentation/developers-and-admins/deployment/deploy-to-private-cloud/deploy-without-the-administration)
- [Azure Blob Storage for private cloud](https://docs.kentico.com/documentation/developers-and-admins/api/files-api-and-cms-io/file-system-providers/azure-blob-storage)
- [Continuous Deployment](https://docs.kentico.com/documentation/developers-and-admins/ci-cd/continuous-deployment)
- [HashiCorp Terraform Style Guide](https://developer.hashicorp.com/terraform/language/style)