# Terraform Modules
This is a compilation of mulitple terraform modules we use for various services within the company. Whenever we need a particular service, we pull the corresponding module from this repo and plan and deploy.

## Structure
- **modules**
This is where the various modules code resides.
- **examples**
This are various examples build using the above modules.

## Prerequisites
- Terraform 1.x.x

## Module List
### 1. VPC with Multiple subnets - AWS 
[VPC with Multiple subnets - AWS](/terraform/aws/modules/vpc/vpc.tf)

    This module will create a fully functional VPC with multiple subnets in AWS via Terraform.
### 2. VPC - GCP
[VPC - GCP](/terraform/gcp/modules/vpc/vpc.tf)

    This module will create a fully functional VPC in GCP via Terraform.
### 3. Create S3 buckets - AWS
[S3 - GCP](/terraform/aws/modules/s3/s3.tf)

    This module will create S3 buckets with logging, and version in AWS via Terraform
