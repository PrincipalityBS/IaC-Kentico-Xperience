variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name (3–24 chars, lowercase alphanumeric only)"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must be 3–24 lowercase alphanumeric characters with no hyphens or underscores."
  }
}

variable "account_tier" {
  type        = string
  description = "Storage account performance tier"
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  type        = string
  description = "Storage account replication type (LRS, ZRS, GRS, RAGRS, GZRS, RAGZRS)"
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of: LRS, ZRS, GRS, RAGRS, GZRS, RAGZRS."
  }
}

variable "container_name" {
  type        = string
  description = "Blob container name for Kentico file system mapping (default matches Kentico's AddAppServiceStoragePathMapping default)"
  default     = "cmsstorage"
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Allow shared key (access key) authentication. Set to false once managed identity is confirmed working."
  default     = true
}

variable "managed_identity_principal_id" {
  type        = string
  description = "Principal ID of the managed identity to grant Storage Blob Data Owner. Omit to skip role assignment."
  default     = null
  nullable    = true
}
