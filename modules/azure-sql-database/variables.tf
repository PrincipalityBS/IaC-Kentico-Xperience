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

  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.mssql_database_license)
    error_message = "mssql_database_license must be 'LicenseIncluded' or 'BasePrice'."
  }
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

