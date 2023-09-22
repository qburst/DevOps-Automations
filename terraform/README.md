# Terraform Modules
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
[S3 - AWS](/terraform/aws/modules/s3/s3.tf)

    This module will create S3 buckets with logging, and version in AWS via Terraform

### 4. Cloud Function v2 - GCP
[Cloud Function v2 - GCP](/terraform/gcp/modules/cloud_function_v2/function_v2.tf)

    This module will create a simple cloud function with an http trigger via Terraform.

### 5. Compute Engine - GCP
[Compute Engine -GCP](/terraform/gcp/modules/compute_engine/compute_engine.tf)

    This module will create a VM instance with the image chosen by the user (defaults to Ubuntu 22.04)
