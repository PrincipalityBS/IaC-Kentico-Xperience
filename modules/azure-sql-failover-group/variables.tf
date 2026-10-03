variable "failover_group_name" {
  type        = string
  description = "Name of the SQL auto-failover group"
}

variable "primary_server_id" {
  type        = string
  description = "Resource ID of the primary MSSQL server"
}

variable "secondary_server_id" {
  type        = string
  description = "Resource ID of the secondary (DR) MSSQL server"
}

variable "database_ids" {
  type        = list(string)
  description = "List of database resource IDs to include in the failover group"
}

variable "grace_minutes" {
  type        = number
  description = "Minutes of data loss grace period before automatic failover triggers"
  default     = 60

  validation {
    condition     = var.grace_minutes >= 0 && var.grace_minutes <= 10080
    error_message = "grace_minutes must be between 0 and 10080 (7 days)."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}
