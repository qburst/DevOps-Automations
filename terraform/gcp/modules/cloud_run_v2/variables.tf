variable "service_name" {
  type    = string
  default = "default-service"
}

variable "make_public" {
  type    = bool
  default = false

}

variable "location" {
  type    = string
  default = ""
}

variable "vpc_connector" {
  type    = string
  default = ""

}

variable "img_url" {
  type    = string
  default = ""
}

variable "min_instance_count" {
  type    = number
  default = 0
}

variable "max_instance_count" {
  type    = number
  default = 1
}

variable "container_port" {
  type    = number
  default = null

}

variable "container_env" {
  type = list(object({
    key   = string
    value = string
  }))
  default = []

}