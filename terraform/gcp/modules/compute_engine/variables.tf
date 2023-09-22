
variable "name" {
  type = string
  default = ""
}
variable "machine_type" {
  type = string
  default = "e2-medium"
}
variable "zone" {
  type = string
  default = "us-central1-a"
}
variable "image" {
  type = string
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}
variable "network" {
  type = string
  default=""

}