# Terraform Modules
## Structure
- **modules**
This is where the various modules code resides.
- **examples**
This are various examples build using the above modules.

## Prerequisites
- Terraform 1.x.x

## Module List
### AWS
#### 1. VPC with Multiple subnets
[VPC with Multiple subnets - AWS](/terraform/aws/modules/vpc/)

    This module will create a fully functional VPC with multiple subnets in AWS via Terraform.

#### 2. Create S3 buckets
[S3 - AWS](/terraform/aws/modules/s3/)

    This module will create S3 buckets with logging, and version in AWS via Terraform.

#### 3. Create EC2 Instances
[EC2 - AWS](/terraform/aws/modules/ec2/)

    This module will create EC2 instances and required key pairs and security groups.

#### 4. EFS - AWS
[Elastic File System -AWS](/terraform/aws/modules/efs/)

    This module will create EFS in AWS via Terraform.

#### 5. RDS - AWS
[Amazon Relational Database service -AWS](/terraform/aws/modules/rds/)

    This module will create RDS in AWS via Terraform.

### GCP
#### 1. VPC
[VPC - GCP](/terraform/gcp/modules/vpc/)

    This module will create a fully functional VPC in GCP via Terraform.

#### 2. Cloud Function v2
[Cloud Function v2 - GCP](/terraform/gcp/modules/cloud_function_v2/)

    This module will create a simple cloud function with an http trigger via Terraform.

#### 3. Compute Engine
[Compute Engine -GCP](/terraform/gcp/modules/compute_engine/)

    This module will create a VM instance with the image chosen by the user (defaults to Ubuntu 22.04)

### 4. Cloud Run v2
[Cloud Run v2 - GCP](/terraform/gcp/modules/cloud_run_v2/)

    This module will create a cloud run service for a public facing web applications or APIs.

### Azure
#### 1. VNET
[VNET - Azure](/terraform/azure/modules/vnet/)

    This module will launch a complete Azure VNET

#### 2. Azure VM
[VM - Azure](/terraform/azure/modules/azure-vm/)

    This module will launch a VM instance in Azure
