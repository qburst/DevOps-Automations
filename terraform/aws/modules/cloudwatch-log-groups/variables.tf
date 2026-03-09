variable "log_group_names" {
  description = "List of CloudWatch log group names to create."
  type        = list(string)
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt log groups at rest."
  type        = string
}

variable "retention_in_days" {
  description = "Number of days to retain logs in CloudWatch."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Map of tags to apply to the log groups."
  type        = map(string)
  default     = {}
}

