variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "front_door_profile_name" {
  type        = string
  description = "Name of the Front Door profile"
}


variable "front_door_sku_name" {
  type        = string
  description = "Name of the Front Door SKU"

  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.front_door_sku_name)
    error_message = "front_door_sku_name must be 'Standard_AzureFrontDoor' or 'Premium_AzureFrontDoor'."
  }
}

variable "front_door_endpoint_name" {
  type        = string
  description = "Name of the Front Door endpoint"
}

variable "front_door_origin_group_name" {
  type        = string
  description = "Name of the Front Door origin group"
}

variable "front_door_origin_name" {
  type        = string
  description = "Name of the Front Door origin"
}

variable "front_door_route_name" {
  type        = string
  description = "Name of the Front Door route"
}

variable "default_hostname" {
  type        = string
  description = "Default hostname"
}