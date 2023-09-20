variable "function_name" {
  description = "Name for the Lambda function"
}

variable "handler" {
  description = "The function entry point in the format 'filename.handler'"
}

variable "runtime" {
  description = "The runtime for the Lambda function (e.g., nodejs14.x, python3.8)"
}

variable "source_code_path" {
  description = "The path to the Lambda function code"
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "timeout" {
  description = "Maximum execution time for the Lambda function (in seconds)"
  default     = 60
}

variable "memory_size" {
  description = "The amount of memory in MB allocated to the Lambda function"
  default     = 128
}
variable "name_prefix" {
  type    = string
  default = "common"
}
variable "description" {
  description = "description of the lambda-function"
  
}
