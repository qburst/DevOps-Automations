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
variable "subnet_id" {
  type = list(string)
  default = []

}
variable "security_groups" {
  type = list(string)
  default = []
}

