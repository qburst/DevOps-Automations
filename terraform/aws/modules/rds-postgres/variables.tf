variable "identifier" {
  description = "Cluster identifier for the Aurora PostgreSQL cluster. Must be unique within the account and region."
  type        = string
}

variable "engine_version" {
  description = "Version of the Aurora PostgreSQL engine to use (for example, 15.5)."
  type        = string
}

variable "engine_mode" {
  description = "Engine mode for the Aurora PostgreSQL cluster. Use `provisioned` for standard instances or `serverless` for Aurora Serverless."
  type        = string
  default     = "provisioned"
}

variable "instance_class" {
  description = "Instance class for Aurora PostgreSQL cluster instances (for example, db.r6g.large). Used when engine_mode is `provisioned`."
  type        = string
}

variable "db_name" {
  description = "Name of the initial database to create."
  type        = string
}

variable "username" {
  description = "Master username for the Aurora PostgreSQL cluster."
  type        = string
}

variable "password" {
  description = "Master password for the Aurora PostgreSQL cluster."
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "Name of an existing DB subnet group to associate with this RDS instance. The subnet group must reference trusted subnets only. If not set, the module will create its own subnet group"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of existing VPC security group IDs to associate with the Aurora cluster. Security groups are managed externally; this module does not create them."
  type        = list(string)
}

variable "kms_key_id" {
  description = "ARN or ID of the KMS key to use for encrypting the Aurora cluster storage and snapshots."
  type        = string
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups. Set to 0 to disable automated backups."
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window in UTC (for example, 03:00-04:00)."
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Preferred maintenance window in UTC (for example, sun:04:00-sun:05:00)."
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "multi_az" {
  description = "Reserved for compatibility. Aurora clusters inherently provide high availability across AZs."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "If true, enables deletion protection for the Aurora cluster."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Reserved for compatibility. Final snapshot behavior is controlled at the cluster level via deletion_protection and lifecycle policies."
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "Identifier for the final snapshot to create when the Aurora cluster is destroyed and skip_final_snapshot is false."
  type        = string
  default     = ""
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades are applied automatically to Aurora instances during the maintenance window."
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any Aurora cluster modifications are applied immediately, or during the next maintenance window."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of tags to apply to the Aurora cluster and its instances."
  type        = map(string)
  default     = {}
}

variable "instance_count" {
  description = "Number of Aurora cluster instances to create when engine_mode is `provisioned`."
  type        = number
  default     = 2
}

variable "serverless_min_capacity" {
  description = "Minimum capacity for Aurora Serverless (ACUs). Used when engine_mode is `serverless`."
  type        = number
  default     = 2
}

variable "serverless_max_capacity" {
  description = "Maximum capacity for Aurora Serverless (ACUs). Used when engine_mode is `serverless`."
  type        = number
  default     = 8
}

variable "serverless_auto_pause" {
  description = "Whether to enable automatic pause for Aurora Serverless when there are no connections."
  type        = bool
  default     = false
}

variable "serverless_seconds_until_auto_pause" {
  description = "Time in seconds before the Aurora Serverless cluster is auto-paused. Used when auto_pause is true."
  type        = number
  default     = 300
}

variable "region" {
  description = "AWS region where the RDS cluster will be created."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs to use for the DB subnet group."
  type        = list(string)
  default     = []
}

variable "cluster_parameters" {
  description = "List of cluster parameters to apply. Each parameter should have name, value, and optionally apply_method."
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string)
  }))
  default = []
}

variable "db_parameters" {
  description = "List of DB parameters to apply. Each parameter should have name, value, and optionally apply_method."
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string)
  }))
  default = []
}


