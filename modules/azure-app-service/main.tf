terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>5.0"
    }
  }
}
resource "azurerm_service_plan" "main" {
  name                = var.serviceplan_name
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = var.serviceplan_os
  sku_name            = var.serviceplan_sku
  zone_balancing_enabled = var.serviceplan_zone_balancing_enabled
  worker_count         = var.serviceplan_workercount
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
    tags["MG-Environment"],tags["MG-Service"]
    ]
  }
}

resource "azurerm_windows_web_app" "main" {
  name                = var.app_name
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id
  https_only          = true
  tags                = var.tags

  dynamic "identity" {
    for_each = var.managed_identity_id != null ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = [var.managed_identity_id]
    }
  }

  site_config {
    ip_restriction_default_action = var.ip_address_default_action

    # Front Door lockdown mode: AzureFrontDoor.Backend service tag + FDID header validates traffic is from THIS profile
    dynamic "ip_restriction" {
      for_each = var.enable_frontdoor_lockdown ? [1] : []
      content {
        action      = "Allow"
        service_tag = "AzureFrontDoor.Backend"
        priority    = 100
        name        = "Allow Azure Front Door"
        headers {
          x_azure_fdid      = var.frontdoor_resource_guid != null ? [var.frontdoor_resource_guid] : []
          x_forwarded_for   = []
          x_forwarded_host  = []
          x_fd_health_probe = []
        }
      }
    }

    # DR bypass: direct-access IPs active only in lockdown mode, for emergency use when Front Door is unavailable
    dynamic "ip_restriction" {
      for_each = var.enable_frontdoor_lockdown ? {
        for idx, ip in var.dr_bypass_ip_addresses : tostring(idx) => ip
      } : {}
      content {
        action     = "Allow"
        ip_address = ip_restriction.value
        priority   = 200 + tonumber(ip_restriction.key)
        name       = "DR Bypass ${tonumber(ip_restriction.key) + 1}"
      }
    }

    # Standard rules — active when NOT in Front Door lockdown mode
    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = var.ip_restriction_action
        ip_address = var.ip_restriction_ip_address
        priority   = var.ip_restriction_priority
        name       = var.ip_restriction_name
      }
    }

    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = "Allow"
        ip_address = "155.190.0.0/16,151.186.0.0/16,146.112.0.0/16"
        priority   = 110
        name       = "Allow Umbrella IP's"
      }
    }

    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = "Allow"
        ip_address = "152.37.118.72/32,86.12.80.71/32,82.15.130.55/32"
        priority   = 119
        name       = "Allow Brand Potential Users"
      }
    }

    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = "Allow"
        ip_address = "82.69.82.75/32,90.195.223.85/32,152.37.66.17/32,81.98.85.203/32,86.2.33.139/32,143.58.156.251/32,82.10.143.131/32,89.101.123.206/32"
        priority   = 120
        name       = "Allow Marketing Home Users 1"
      }
    }

    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = "Allow"
        ip_address = "90.204.76.92/32,81.77.229.74/32,81.159.74.144/32,83.105.56.91/32,82.16.172.70/32,90.192.4.84/32,152.37.76.132/32,148.253.177.242/32"
        priority   = 121
        name       = "Allow Marketing Home Users 2"
      }
    }

    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = "Allow"
        ip_address = "90.209.57.102/32,152.37.109.215/32,88.97.214.223/32,155.190.33.6/32,94.8.103.123/32,176.25.242.187/32,88.97.220.72/32,82.18.170.153/32"
        priority   = 122
        name       = "Allow Marketing Home Users 3"
      }
    }

    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = "Allow"
        ip_address = "185.81.255.167/32,137.220.72.25/32,81.77.87.17/32,94.5.94.213/32,94.5.37.142/32,86.185.204.146/32,86.176.167.181/32,88.97.202.65/32"
        priority   = 123
        name       = "Allow Marketing Home Users 4"
      }
    }

    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = "Allow"
        ip_address = "5.65.7.75/32,152.37.77.166/32,159.65.214.88/32,157.230.65.35/32,46.64.115.110/32,188.221.46.205/32,155.190.33.29/32,86.19.24.67/32"
        priority   = 124
        name       = "Allow Umbrella IP's (original)"
      }
    }

    dynamic "ip_restriction" {
      for_each = !var.enable_frontdoor_lockdown ? [1] : []
      content {
        action     = "Allow"
        ip_address = "62.254.240.129/32,20.95.71.0/32,86.31.169.139/32"
        priority   = 131
        name       = "Allow zScaler Pinned IP's"
      }
    }

    # VNet subnet always allowed regardless of mode
    ip_restriction {
      action                    = "Allow"
      virtual_network_subnet_id = data.azurerm_subnet.main.id
      priority                  = 130
      name                      = "Allow VNet Subnet"
    }

    ftps_state        = "Disabled"
    use_32_bit_worker = false
  }
  app_settings = {
    currentstack              = "dotnetcore"
    dotnetversion             = "v7.0"
    WEBSITE_TIME_ZONE         = "GMT Standard Time"
    WEBSITE_LOAD_USER_PROFILE = "1"
  }

  virtual_network_subnet_id = data.azurerm_subnet.main.id

  lifecycle {
    precondition {
      condition     = !var.enable_frontdoor_lockdown || var.frontdoor_resource_guid != null
      error_message = "frontdoor_resource_guid must be set when enable_frontdoor_lockdown is true."
    }
    ignore_changes = [
      tags["MG-Environment"], tags["MG-Service"], app_settings, logs
    ]
  }
}

# resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
#   app_service_id  = azurerm_windows_web_app.main.id
#   subnet_id       = data.azurerm_subnet.main.id
# }
