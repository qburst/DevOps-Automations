variable "name" {
  description = "The name"
  type        = string
  default     = "common"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
  default     = ""
}

variable "allowed_cidr" {
  description = "The CIDR blocks allowed in Security group"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "Elastic cache engine"
  type        = string
  default     = "memcached"
}

variable "engine_version" {
  description = "Cache engine version. For more info, see https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/supported-engine-versions.html"
  type        = string
  default     = "1.6.17"
}

variable "instance_type" {
  description = "Elastic cache instance type"
  type        = string
  default     = "cache.t2.micro"
}

variable "cluster_size" {
  description = "Cluster size"
  type        = number
  default     = 1
}

variable "parameter_group_name" {
  description = "Name of the cache parameter group to associate"
  type        = string
  default     = ""
}

variable "parameter_group_family" {
  description = "Name of the cache parameter group family"
  type        = string
  default     = "memcached1.6"
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = ""
}

variable "notification_topic_arn" {
  description = "An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:xxxxxxxxxx:my_sns_topic"
  type        = string
  default     = ""
}

variable "port" {
  description = "Cache port"
  type        = number
  default     = 11211
}

variable "az_mode" {
  description = "Enable or disable multiple AZs, eg: single-az or cross-az"
  type        = string
  default     = "single-az"
}

variable "availability_zone" {
  description = "The Availability Zone of the cluster. az_mode must be set to single-az when used."
  type        = string
  default     = ""
}

variable "availability_zones" {
  description = "List of Availability Zones for the cluster. az_mode must be set to cross-az when used."
  type        = list(string)
  default     = []
}

variable "replication_group_enabled" {
  description = "replication group status for redis"
  type        = string
  default     = "disabled"
}

variable "redis_failover" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window"
  type        = bool
  default     = true
}

variable "multi_az_enabled" {
  description = "Specifies whether to enable Multi-AZ Support for the replication group"
  type        = bool
  default     = false
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true"
  type        = string
  default     = ""
}

variable "transit_encryption_enabled" {
  description = "Whether to enable encryption in transit. Requires 3.2.6 or >=4.0 redis_version"
  type        = bool
  default     = false
}

variable "auth_token" {
  description = "The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true. If specified must contain from 16 to 128 alphanumeric characters or symbols"
  type        = string
  default     = ""
}

# might need a map ( If the version is 6 or higher, the major and minor version can be set)
variable "redis_version" {
  description = "Redis version to use, defaults to 3.2.10"
  type        = string
  default     = "3.2.10"
}

variable "security_group_names" {
  description = "A list of cache security group names to associate with this replication group"
  type        = list(string)
  default     = []
}

variable "snapshot_arns" {
  description = "A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb"
  type        = list(string)
  default     = []
}

variable "snapshot_name" {
  description = " The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource"
  type        = string
  default     = ""
}

variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
  type        = bool
  default     = false
}

variable "redis_snapshot_window" {
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period"
  type        = string
  default     = "06:30-07:30"
}

variable "redis_snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes"
  type        = number
  default     = 0
}

variable "num_node_groups" {
  description = "Number of node groups (shards) for this Redis replication group. Changing this number will trigger a resizing operation before other settings modifications."
  type        = number
  default     = 0
}

variable "replicas_per_node_group" {
  description = "Number of replica nodes in each node group. Changing this number will trigger a resizing operation before other settings modifications. Valid values are 0 to 5."
  type        = number
  default     = 0
}

