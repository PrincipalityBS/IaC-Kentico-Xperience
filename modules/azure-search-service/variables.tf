variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
  }
}

variable "search_service_name" {
  type        = string
  description = "Name of the search service"
}

variable "search_service_sku" {
  type        = string
  description = "SKU of the search service"

  validation {
    condition     = contains(["free", "basic", "standard", "standard2", "standard3", "storage_optimized_l1", "storage_optimized_l2"], var.search_service_sku)
    error_message = "search_service_sku must be one of: free, basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2."
  }
}

variable "search_service_public_network_access_enabled" {
  type        = bool
  description = "Flag to enable/disable public network access for the search service"
}
