variable "replication_instance_id" {
  description = "Identifier for the DMS replication instance. Must be unique within the account and region."
  type        = string
}

variable "replication_instance_class" {
  description = "Instance class for the DMS replication instance (for example, dms.t3.medium)."
  type        = string
}

variable "allocated_storage" {
  description = "Amount of allocated storage in GiB for the DMS replication instance."
  type        = number
  default     = 100
}

variable "engine_version" {
  description = "Version of the DMS replication engine to use."
  type        = string
  default     = "3.5.0"
}

variable "multi_az" {
  description = "If true, creates a Multi-AZ DMS replication instance."
  type        = bool
  default     = false
}

variable "replication_subnet_group_id" {
  description = "ID of an existing DMS replication subnet group. If empty, the module creates one using subnet_ids (must be in at least two AZs)."
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DMS replication subnet group when the module creates it (required if replication_subnet_group_id is empty). Must include subnets in at least two AZs."
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "List of existing VPC security group IDs to associate with the DMS replication instance ENIs. Security groups are managed externally; this module does not create them."
  type        = list(string)
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt DMS replication instance storage and logs."
  type        = string
}

variable "maintenance_window" {
  description = "Preferred maintenance window in UTC for the DMS replication instance."
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades are applied automatically during the maintenance window."
  type        = bool
  default     = true
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major engine upgrades are allowed."
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Specifies whether modifications are applied immediately or during the next maintenance window."
  type        = bool
  default     = false
}

variable "replication_task_id" {
  description = "Identifier for the DMS replication task."
  type        = string
}

variable "migration_type" {
  description = "Type of migration task. Valid values: full-load, cdc, full-load-and-cdc."
  type        = string
}

variable "source_endpoint_arn" {
  description = "ARN of an existing DMS source endpoint. If empty, the module creates a source endpoint using source_* variables."
  type        = string
  default     = ""
}

variable "target_endpoint_arn" {
  description = "ARN of an existing DMS target endpoint. If empty, the module creates a target endpoint using target_* variables."
  type        = string
  default     = ""
}

# Source endpoint (used when source_endpoint_arn is empty)
variable "source_endpoint_id" {
  description = "Identifier for the DMS source endpoint. Required when creating the source endpoint (source_endpoint_arn empty)."
  type        = string
  default     = ""
}

variable "source_engine_name" {
  description = "Engine name for the source endpoint (e.g. postgres, mysql, aurora-postgresql). Required when creating the source endpoint."
  type        = string
  default     = ""
}

variable "source_server_name" {
  description = "Hostname or IP of the source database. Required when creating the source endpoint."
  type        = string
  default     = ""
}

variable "source_port" {
  description = "Port of the source database. Required when creating the source endpoint."
  type        = number
  default     = 5432
}

variable "source_database_name" {
  description = "Name of the source database. Required when creating the source endpoint."
  type        = string
  default     = ""
}

variable "source_username" {
  description = "Username for the source database. Required when creating the source endpoint."
  type        = string
  default     = ""
  sensitive   = true
}

variable "source_password" {
  description = "Password for the source database. Required when creating the source endpoint."
  type        = string
  default     = ""
  sensitive   = true
}

variable "source_ssl_mode" {
  description = "SSL mode for the source endpoint: none, require, verify-ca, verify-full."
  type        = string
  default     = "none"
}

variable "source_extra_connection_attributes" {
  description = "Extra connection attributes for the source endpoint."
  type        = string
  default     = ""
}

# Target endpoint (used when target_endpoint_arn is empty)
variable "target_endpoint_id" {
  description = "Identifier for the DMS target endpoint. Required when creating the target endpoint (target_endpoint_arn empty)."
  type        = string
  default     = ""
}

variable "target_engine_name" {
  description = "Engine name for the target endpoint (e.g. aurora-postgresql, postgres). Required when creating the target endpoint."
  type        = string
  default     = ""
}

variable "target_server_name" {
  description = "Hostname or IP of the target database. Required when creating the target endpoint."
  type        = string
  default     = ""
}

variable "target_port" {
  description = "Port of the target database. Required when creating the target endpoint."
  type        = number
  default     = 5432
}

variable "target_database_name" {
  description = "Name of the target database. Required when creating the target endpoint."
  type        = string
  default     = ""
}

variable "target_username" {
  description = "Username for the target database. Required when creating the target endpoint."
  type        = string
  default     = ""
  sensitive   = true
}

variable "target_password" {
  description = "Password for the target database. Required when creating the target endpoint."
  type        = string
  default     = ""
  sensitive   = true
}

variable "target_ssl_mode" {
  description = "SSL mode for the target endpoint: none, require, verify-ca, verify-full."
  type        = string
  default     = "none"
}

variable "target_extra_connection_attributes" {
  description = "Extra connection attributes for the target endpoint."
  type        = string
  default     = ""
}

variable "table_mappings" {
  description = "JSON document that specifies table selection and transformation rules for the DMS task."
  type        = string
}

variable "replication_task_settings" {
  description = "JSON document that provides advanced settings for the DMS replication task."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Map of tags to apply to the DMS replication resources."
  type        = map(string)
  default     = {}
}

