#Global Variables
variable "primary_subscription_id" {
  type        = string
  description = "Primary Subscription ID"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}
variable "location" {
  type        = string
  description = "Location of cluster"
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group"
}

#Managed Identity
variable "managed_identity_name" {
  type        = string
  description = "Name of the user-assigned managed identity"
}

#Storage Account (Kentico Blob Storage)
variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name (3–24 chars, lowercase alphanumeric). Used for Kentico file system mapping."
}

variable "storage_replication_type" {
  type        = string
  description = "Storage account replication type"
  default     = "LRS"
}

variable "storage_container_name" {
  type        = string
  description = "Blob container name for Kentico storage path mapping"
  default     = "cmsstorage"
}

#Variables for main Application Site
variable "mainsite-serviceplan_sku" {
  type        = string
  description = "Service Plan sku"
}

variable "mainsite-serviceplan_name" {
  type        = string
  description = "Service Plan Name"
}

variable "mainsite-serviceplan_os" {
  type        = string
  description = "Service Plan OS type"
}

variable "mainsite-app_name" {
  type        = string
  description = "Application Name"
}
variable "mainsite-serviceplan_zone_balancing_enabled" {
  type        = bool
  description = "Zone LB enabled"
}

#Variables for Admin Application Site
variable "adminsite-serviceplan_sku" {
  type        = string
  description = "Service Plan sku"
}

variable "adminsite-serviceplan_name" {
  type        = string
  description = "Service Plan name"
}

variable "adminsite-serviceplan_os" {
  type        = string
  description = "Service Plan OS type"
}

variable "adminsite-app_name" {
  type        = string
  description = "Application Name"
}

variable "adminsite-serviceplan_zone_balancing_enabled" {
  type        = bool
  description = "Zone LB enabled"
}

#Variable set for azurerm_mssql_server
variable "mssql_server_name" {
  type        = string
  description = "MSSQL server name"
}

variable "mssql_server_version" {
  type        = string
  description = "MSSQL server version"
}

variable "mssql_server_administrator" {
  type        = string
  description = "MSSQL server administrator login"
}

variable "mssql_server_password" {
  type        = string
  description = "MSSQL server administrator password"
  sensitive   = true
}

#Variable set for azurerm_mssql_database
variable "mssql_database_name" {
  type        = string
  description = "MSSQL database name"
}

variable "mssql_database_collation" {
  type        = string
  description = "MSSQL database collation"
}

variable "mssql_database_license" {
  type        = string
  description = "MSSQL database license"
}

variable "mssql_database_max_size_gb" {
  type        = number
  description = "MSSQL database max size gb"
}

variable "mssql_database_read_scale" {
  type        = bool
  description = "MSSQL database read scale"
}

variable "mssql_database_sku_name" {
  type        = string
  description = "MSSQL database sku name"
}

variable "mssql_database_zone_redundant" {
  type        = bool
  description = "MSSQL database zone redundancy"
}

variable "mssql_database_enclave_type" {
  type        = string
  description = "MSSQL database enclave type"
}

#Search Instance Configuration
variable "search_service_name" {
  type        = string
  description = "Name of the search service"
}

variable "search_service_sku" {
  type        = string
  description = "SKU of the search service"
}

variable "search_service_public_network_access_enabled" {
  type        = bool
  description = "Flag to enable/disable public network access for the search service"
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

variable "webmain_ip_address_default_action" {
  type        = string
  description = "Default action for IP restriction"
}

variable "webmain_ip_restriction_action" {
  type        = string
  description = "Action for IP restriction" 
}

variable "webmain_ip_restriction_ip_address" {
  type        = string
  description = "IP Address for IP restriction"
}

variable "webmain_ip_restriction_priority" {
  type        = number
  description = "Priority for IP restriction"
}

variable "webmain_ip_restriction_name" {
  type        = string
  description = "Name for IP restriction"
}

#Front Door lockdown (Main Site)
variable "mainsite_enable_frontdoor_lockdown" {
  type        = bool
  description = "When true, restricts main site App Service to Azure Front Door IPs only"
  default     = false
}

variable "mainsite_frontdoor_resource_guid" {
  type        = string
  description = "Resource GUID of the Front Door profile (azurerm_cdn_frontdoor_profile.resource_guid). Required when mainsite_enable_frontdoor_lockdown is true."
  default     = null
  nullable    = true
}

variable "mainsite_dr_bypass_ip_addresses" {
  type        = list(string)
  description = "IP CIDR ranges allowed direct access to the main site when Front Door lockdown is active (emergency DR bypass)"
  default     = []
}

variable "webadmin_ip_address_default_action" {
  type        = string
  description = "Default action for IP restriction"
}

variable "webadmin_ip_restriction_action" {
  type        = string
  description = "Action for IP restriction" 
}

variable "webadmin_ip_restriction_ip_address" {
  type        = string
  description = "IP Address for IP restriction"
}

variable "webadmin_ip_restriction_priority" {
  type        = number
  description = "Priority for IP restriction"
}

variable "webadmin_ip_restriction_name" {
  type        = string
  description = "Name for IP restriction"
}