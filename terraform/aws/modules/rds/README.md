# AWS RDS terraform project

Terraform module which creates standalone AWS RDS resources

## Introduction

The module will create:

- DB instance (MySQL, Postgres, SQL Server, Oracle)
- DB Subnet Group
- DB Security Group

The project is organized into the following directories and files:

- **/DevOps-Automations/terraform/aws/modules/rds**: This directory contains the Terraform modules for setting up the RDS instance

  - `rds.tf`: Defines the rds instance and its dependent resources like subnet group and security group.
  - `variables.tf`: Declares input variables used throughout the module.
  - `outputs.tf`: Defines the output values of the module.
  
- **/DevOps-Automations/terraform/aws/examples/rds**: This directory contains example configurations that use the rds module defined in the `modules/rds` directory.

  - `provider.tf`: Configures the Terraform provider for AWS and specifies the default AWS region.
  - `main.tf`: Calls both the RDS and VPC module and passes input variables to create an RDS instance and its associated infrastructure within the VPC.

- **/DevOps-Automations/terraform/aws/modules/vpc**: This directory contains the Terraform module for configuring the VPC.


## Prerequisites

Before using this Terraform configuration, ensure you have the following prerequisites:

1. [Terraform](https://www.terraform.io/) (v1.5.0 or later) installed.
2. AWS CLI configured with appropriate access credentials.

## Configuration

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_password.db-password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_kms_key.db_ssm_encrypt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_ssm_parameter.db-password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |



## Inputs

| Name | Description | Type |
|------|-------------|:--------:|
|database_port | Database port Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids` | `number` |
| database_user | Username for the primary DB user, Required unless a snapshot_identifier is provided.| `string` |
| engine | Database engine type. | `string` |
| engine_version | Database engine version, depends on engine type | `string` |
| instance_class | Class of RDS instance | `string` |
| vpc_id | VPC ID the DB instance will be created in | `string` |
| allocated_storage | The allocated storage in GBs, Required unless a snapshot_identifier is provided.| `number` |
| subnet_ids | List of subnet IDs for the DB. DB instance will be created in the VPC associated with the DB subnet group provisioned using the subnet IDs.| `list(string)` |
|| db-identifier    | Identifier for the RDS DB instance. | `string`     |
| database_name    | Name of the database to be created on the RDS instance.  | `string`     |
| snapshot_identifier  |  whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console. | `string`  |







## Usage

To use this Terraform project, follow these steps:

1. Clone this repository:
   ```bash
   git clone <repository_url>
   ```
2. Change to the project directory:
   ```bash
   cd terraform/aws/examples/rds
   ```
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Review the plan to ensure everything looks correct:
   ```bash
   terraform plan
   ```
5. Apply the Terraform configuration to create the Lambda function and associated resources:
   ```bash
   terraform apply

## Note:

To establish a connection with the database, follow these steps:

1. Create an EC2 instance in the same VPC where the RDS is deployed.
2. Install MySQL or any appropriate database client on the EC2 instance.
4. Retrieve the database password securely from AWS Systems Manager Parameter Store
3. Use the following connection command:

```bash
mysql -h <RDS_endpoint> -u <username> -p



**Cleanup**

To destroy the created resources and clean up, run:

```bash
terraform destroy
