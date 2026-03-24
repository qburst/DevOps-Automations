variable "name" {
  description = "Name of the ECS cluster to create. Choose a name that aligns with landing zone naming conventions."
  type        = string
}

variable "enable_container_insights" {
  description = "If true, enables CloudWatch Container Insights for the ECS cluster."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags to apply to the ECS cluster."
  type        = map(string)
  default     = {}
}