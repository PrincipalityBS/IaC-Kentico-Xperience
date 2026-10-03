variable "location" {
  type        = string
  description = "Azure Region Location"
}
 
variable "resource_group" {
  type        = string
  description = "Resource Group Name"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "serviceplan_sku" {
  type        = string
  description = "Service Plan SKU"
}

variable "serviceplan_name" {
  type        = string
  description = "Service Plan name"
}

variable "serviceplan_os" {
  type        = string
  description = "Service Plan OS type"

  validation {
    condition     = contains(["Windows", "Linux"], var.serviceplan_os)
    error_message = "serviceplan_os must be 'Windows' or 'Linux'."
  }
}

variable "serviceplan_zone_balancing_enabled" {
  type        = bool
  description = "Zone balancing enabled"
  default     = false
}

variable "serviceplan_workercount" {
  type        = number
  description = "Service plan worker count"
  default     = 1
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

#Network Configuration (data resource)
variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual Network name"
}

variable "network_resource_group" {
  type        = string
  description = "Resource Group for Network"
}

variable "ip_address_default_action" {
  type        = string
  description = "Default action for IP restriction"
}

variable "ip_restriction_action" {
  type        = string
  description = "Action for IP restriction" 
}

variable "ip_restriction_ip_address" {
  type        = string
  description = "IP Address for IP restriction"
}

variable "ip_restriction_priority" {
  type        = number
  description = "Priority for IP restriction"
}

variable "ip_restriction_name" {
  type        = string
  description = "Name for IP restriction"
}

#Front Door lockdown
variable "enable_frontdoor_lockdown" {
  type        = bool
  description = "When true, restricts access to Azure Front Door IPs only via service tag and FDID header validation"
  default     = false
}

variable "frontdoor_resource_guid" {
  type        = string
  description = "Resource GUID of the Front Door profile for X-Azure-FDID header validation (azurerm_cdn_frontdoor_profile.main.resource_guid). Required when enable_frontdoor_lockdown is true."
  default     = null
  nullable    = true
}

variable "dr_bypass_ip_addresses" {
  type        = list(string)
  description = "IP CIDR ranges granted direct access when Front Door lockdown is active — emergency DR bypass only"
  default     = []
}

variable "managed_identity_id" {
  type        = string
  description = "Resource ID of the user-assigned managed identity to attach. Required for managed identity authentication to Azure Blob Storage."
  default     = null
  nullable    = true
}

