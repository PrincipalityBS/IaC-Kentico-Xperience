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

#Variable set for azurerm_mssql_server
variable "mssql_server_name" {
  type        = string
  description = "MSSQL server name"
}

variable "mssql_server_version" {
  type        = string
  description = "MSSQL server version"

  validation {
    condition     = contains(["2.0", "12.0"], var.mssql_server_version)
    error_message = "mssql_server_version must be '2.0' or '12.0'."
  }
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

