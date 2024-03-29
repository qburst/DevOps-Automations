terraform {
  required_version = "~>1.5.0"
}


provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = "Test"
      Project     = "QBurst"
    }
  }
}

variable "region" {
  type        = string
  description = "The default region to use"
  default     = "us-east-1"
}
