variable "function_name" {
  type = string
  default = "test-function"
}

variable "description" {
    type = string
    default = "A new function"
}
variable "source_dir" {
  type = string
  default = "source"
  
}
variable "location" {
    type = string
}

variable "source_bucket" {
  type = string
  default = ""
}

variable "make_public" {
  type = bool
  default = false
}

variable "config" {
    type = object({
      runtime = string
      entry_point = string
      max_instance_count = optional(number, 1)
      timeout_seconds = optional(number, 60)
      available_memory = optional(string, "256M")
    })
  
}