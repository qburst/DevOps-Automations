variable "region" {
  type        = string
  default     = "ap-south-1"
}

variable "instance_ids" {
  type        = list(string)
  description = "List of EC2 instance IDs to start/stop"
  default     = ["i-0a5631ea52f17301c", "i-0ad6719c702702a1b", "i-076189fd822cb01a9"]
}

variable "function_region" {
  description = "Region needs to specify in the lambda function code"
  type        = string
  default     = "ap-south-1"
}

variable "start_cron_value" {
  description = "Specify the required cron value based on when to start"
  type        = string
  default     = "cron(30 03 ? * MON-FRI *)" #Monday to Friday daily morning 9:00 IST
}

variable "stop_cron_value" {
  description = "Specify the required cron value batopsed on when to stop"
  type        = string
  default     = "cron(30 15 ? * MON-FRI *)" #Monday to Friday daily night 9:00 IST
}