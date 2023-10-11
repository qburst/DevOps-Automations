variable "creation_token" {
  type    = string
  default = "test-efs"

}
variable "performance_mode" {
  type    = string
  default = "generalPurpose"

}
variable "throughput_mode" {
  type    = string
  default = "bursting"

}
variable "encryption_set" {
  type    = bool
  default = true
}
variable "kms_key_id" {
  type    = string
  default = "true"

}
variable "subnet_id" {
  type    = string
  default = "subnet-01234567890abcdef"

}
variable "security_groups" {
  type    = list(string)
  default = ["sg-01234567890abcdef","sg-01234567890abcdef"]

}

