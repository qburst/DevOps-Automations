variable "alias_name" {
  description = "Name for the KMS alias (without 'alias/' prefix)."
  type        = string
}

variable "description" {
  description = "Description of the KMS key."
  type        = string
}

variable "deletion_window_in_days" {
  description = "Number of days to retain the key after deletion."
  type        = number
  default     = 7
}

variable "enable_key_rotation" {
  description = "Whether to enable automatic key rotation."
  type        = bool
  default     = false
}

variable "policy" {
  description = "Key policy JSON. If null, uses default root-only policy."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the KMS key."
  type        = map(string)
  default     = {}
}
