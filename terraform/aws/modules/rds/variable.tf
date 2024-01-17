variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "The IDs of the security groups from which to allow `ingress` traffic to the DB instance"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "The whitelisted CIDRs which to allow `ingress` traffic to the DB instance"
}


variable "database_name" {
  type        = string
  default     = null
  description = "The name of the database to create when the DB instance is created"
}

variable "database_user" {
  type        = string
  description = "Username for the primary DB user. Required unless a `snapshot_identifier` or `replicate_source_db` is provided."
}

variable "database_port" {
  type        = number
  description = "Database port Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids`"
}

variable "deletion_protection" {
  type        = bool
  description = "Set to true to enable deletion protection on the RDS instance"
  default     = false
}

variable "multi_az" {
  type        = bool
  description = "Set to true if multi AZ deployment must be supported"
  default     = false
}

variable "storage_type" {
  type        = string
  description = "'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  default     = "standard"
}

variable "storage_encrypted" {
  type        = bool
  description = "(Optional) Specifies whether the DB instance is encrypted. The default is true if not specified"
  default     = true
}

variable "iops" {
  type        = number
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'. Default is 0 if rds storage type is not 'io1'"
  default     = 0
}

variable "storage_throughput" {
  type        = number
  description = "The storage throughput value for the DB instance. Can only be set when `storage_type` is `gp3`."
  default     = null
}

variable "allocated_storage" {
  type        = number
  description = "The allocated storage in GBs. Required unless a `snapshot_identifier` or `replicate_source_db` is provided."
  default     = null
}

variable "max_allocated_storage" {
  type        = number
  description = "The upper limit to which RDS can automatically scale the storage in GBs"
  default     = 0
}

variable "engine" {
  type        = string
  description = "Database engine type. Required unless a `snapshot_identifier` or `replicate_source_db` is provided."
  default     = null

}

variable "engine_version" {
  type        = string
  description = "Database engine version, depends on engine type."

}

variable "charset_name" {
  type        = string
  description = "The character set name to use for DB encoding. [Oracle & Microsoft SQL only]"
  default     = null
}

variable "instance_class" {
  type        = string
  description = "Class of RDS instance"

}

variable "db_subnet_group_name" {
  type        = string
  default     = null
}

variable "db_parameter_group" {
  type        = string
  description = "The DB parameter group family name. The value depends on DB engine used"
  default     = null
}

variable "publicly_accessible" {
  type        = bool
  description = "Determines if database can be publicly available "
  default     = false
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB. DB instance will be created in the VPC associated with the DB subnet group provisioned using the subnet IDs. Specify one of `subnet_ids`, `db_subnet_group_name` or `availability_zone`"
  type        = list(string)
  default     = []
}

variable "availability_zone" {
  type        = string
  default     = null
  description = "The AZ for the RDS instance. Specify one of `subnet_ids`, `db_subnet_group_name` or `availability_zone`. If `availability_zone` is provided, the instance will be placed into the default VPC"
}


variable "vpc_id" {
  type        = string
  description = "VPC ID the DB instance will be created in"
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Allow automated minor version upgrade "
  default     = true
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Allow major version upgrade"
  default     = false
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC "
  default     = "Mon:03:00-Mon:04:00"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "If true (default), no snapshot will be made before deleting DB"
  default     = true
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy tags from DB to a snapshot"
  default     = true
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention period in days. Must be > 0 to enable backups"
  default     = 0
}

variable "backup_window" {
  type        = string
  description = "When AWS can perform DB snapshots, can't overlap with maintenance window"
  default     = "22:00-03:00"
}

variable "snapshot_identifier" {
  type        = string
  description = "Snapshot identifier. If specified, the module create cluster from the snapshot"
  default     = null
}


variable "parameter_group_name" {
  type        = string
  description = "Name of the DB parameter group to associate"
  default     = ""
}

variable "option_group_name" {
  type        = string
  description = "Name of the DB option group to associate"
  default     = ""
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the existing KMS key to encrypt storage"
  default     = ""
}

variable "performance_insights_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Performance Insights are enabled."
}

variable "performance_insights_kms_key_id" {
  type        = string
  default     = null
  description = "The ARN for the KMS key to encrypt Performance Insights data."
}

variable "performance_insights_retention_period" {
  type        = number
  default     = 7
  description = "The amount of time in days to retain Performance Insights data."
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = []
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported."
}

variable "ca_cert_identifier" {
  type        = string
  description = "The identifier of the CA certificate for the DB instance"
  default     = null
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0."
  default     = "0"
}

variable "monitoring_role_arn" {
  type        = string
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  default     = null
}

variable "iam_database_authentication_enabled" {
  type        = bool
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  default     = false
}

variable "replicate_source_db" {
  type        = string
  description = "Specifies that this resource is a Replicate database"
  default     = null
}

 
variable "timeouts" {
  type = object({
    create = string
    update = string
    delete = string
  })
  description = "A list of DB timeouts to apply to the running code while creating, updating, or deleting the DB instance."
  default = {
    create = "40m"
    update = "80m"
    delete = "60m"
  }

}

variable "tagname" {
  type = string
  default = "Qb"
  description = "Common name prefix"
  
}

variable "license_model" {
  type        = string
  description = "License model for this DB. Optional, but required for some DB Engines."
  default     = ""
}

variable "timezone" {
  type        = string
  description = "Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server"
  default     = null
}

variable "associate_security_group_ids" {
  type        = list(string)
  default     = []
  description = "The IDs of the existing security groups to associate with the DB instance"
}

variable "enabled" {
  type        = bool
  default     = true
  
}

variable "db-identifier"{
  type        = string
  description = "Database identifer"
}