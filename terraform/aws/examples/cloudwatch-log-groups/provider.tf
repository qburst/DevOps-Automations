terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      ManagedBy   = "terraform"
      Project     = "CloudMigration-PoC"
      Environment = "Type-Int"
    }
  }
}

variable "region" {
  type        = string
  description = "The default region to use"
  default     = "ap-northeast-1"
}

