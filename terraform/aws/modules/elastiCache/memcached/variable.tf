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

variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
  type        = bool
  default     = false
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

