terraform {
  required_version = ">= 1.0.0"
}
provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}