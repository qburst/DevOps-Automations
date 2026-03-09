variable "name" {
  description = "Name of the internal Application Load Balancer."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the ALB and target group are created."
  type        = string
}

variable "subnet_ids" {
  description = "List of private or trusted subnet IDs for the ALB. No public subnets should be used."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of existing security group IDs to associate with the ALB. Security groups are managed externally; this module does not create them."
  type        = list(string)
}

variable "idle_timeout" {
  description = "Idle timeout for the ALB in seconds."
  type        = number
  default     = 60
}

variable "target_group_name" {
  description = "Name of the target group associated with the ALB."
  type        = string
}

variable "target_group_port" {
  description = "Port that the target group forwards traffic to."
  type        = number
}

variable "target_type" {
  description = "Type of targets registered with the target group (instance, ip, or lambda)."
  type        = string
  default     = "ip"
}

variable "health_check_path" {
  description = "Path for HTTP health checks."
  type        = string
  default     = "/"
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive health check successes required before considering a target healthy."
  type        = number
  default     = 3
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive health check failures required before considering a target unhealthy."
  type        = number
  default     = 3
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds."
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "Interval between health checks in seconds."
  type        = number
  default     = 30
}

variable "health_check_matcher" {
  description = "HTTP status code matcher for health checks (for example, 200 or 200-399)."
  type        = string
  default     = "200"
}

variable "ssl_policy" {
  description = "Name of the SSL policy for the HTTPS listener."
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate to use for the HTTPS listener."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to ALB resources."
  type        = map(string)
  default     = {}
}

