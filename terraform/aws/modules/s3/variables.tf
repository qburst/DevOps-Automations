variable "bucket_name" {
  type        = list(string)
  default     = []
  description = "A list of all buckets to be created"
}

variable "force_destroy" {
  type        = string
  default     = false
  description = "If set to true, indicates all objects should be deleted from the bucket when the bucket is destroyed"
}

variable "logging" {
  type = object({
    bucket_name = string
    prefix      = string
  })
  default     = null
  description = "A map containing details related to the logging for all the buckets"
}

variable "public_access_block" {
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
  description = "A map of the different public access block settings"
}

variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "If set to true, it will set version on all buckets to Enabled else to Suspended"
}

variable "kms_master_key_arn" {
  type        = string
  default     = ""
  description = "The AWS KMS master key ARN used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`"
}