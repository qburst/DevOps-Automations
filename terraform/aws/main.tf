terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

variable "region" {
  type        = string
  description = "The default region to use"
  default     = "ap-south-1"
}
