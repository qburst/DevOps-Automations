variable "name" {
  description = "Name of the ECR repository. Must be unique within the account and region."
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt images at rest in the ECR repository."
  type        = string
}

variable "scan_on_push" {
  description = "If true, enables image scanning on push for the repository."
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Valid values are MUTABLE and IMMUTABLE."
  type        = string
  default     = "IMMUTABLE"
}

variable "tags" {
  description = "Map of tags to apply to the ECR repository."
  type        = map(string)
  default     = {}
}