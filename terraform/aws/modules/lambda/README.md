# Terraform AWS Lambda Example

This repository provides an example of how to use Terraform to provision an AWS Lambda function along with its associated IAM role and policies.

## Project Structure

- `main.tf`: The main Terraform configuration file that uses the `aws_lambda_function` and `aws_iam_role` resources to create the Lambda function and its IAM execution role.
- `provider.tf`: Defines the AWS provider configuration, including the AWS region.
- `variables.tf`: Declares input variables that can be customized when deploying the infrastructure.
- `outputs.tf`: Defines outputs that provide information about the created resources.
- `lambda.tf`: Contains the Terraform code for provisioning the Lambda function and IAM role, including the attachment of IAM policies.
- `lambda_zip/lambda1.zip`: The Lambda function code packaged in a zip file.
- `README.md`: This documentation file.

## Prerequisites

Before using this Terraform configuration, ensure you have the following prerequisites:

1. [Terraform](https://www.terraform.io/) (v1.5.0 or later) installed.
2. AWS CLI configured with appropriate access credentials.

## Lambda Function Code

The Lambda function code is packaged in a zip file named `lambda1.zip`. To customize and deploy this code, follow these steps:

1. **Customize Your Code:** Place your Lambda function code and any required dependencies inside the `lambda_zip` directory.

2. **Zip Your Code:** Zip the contents of the `lambda_zip` directory, ensuring that the main Lambda function file (e.g., `lambda1.py`, `index.js`) is at the root of the zip file.

3. **Update Terraform Configuration:** In the `main.tf` file, set the `source_code_path` variable to the path of your zip file. For example:

   ```hcl
   source_code_path  = "./lambda_zip/lambda1.zip" 
   ```
## Deploy Using Terraform

Now, you can use Terraform to deploy the Lambda function along with its code.
By following these steps, you can ensure that your Lambda function code is properly packaged and deployed as part of your infrastructure provisioning process.

## Configuration

Customize the Terraform configuration by modifying the following variables in variables.tf:

`function_name`: Name for the Lambda function.
`handler`: The function entry point in the format 'filename.handler'.
`runtime`: The runtime for the Lambda function (e.g., nodejs14.x, python3.8).
`source_code_path`: The path to the Lambda function code.
`environment_variables`: Environment variables for the Lambda function.
`timeout`: Maximum execution time for the Lambda function (in seconds).
`policy_arns`: List of IAM policy ARNs to attach to the Lambda execution role.
`memory_size`: The amount of memory in MB allocated to the Lambda function.
`name_prefix`: Prefix for resource names (default: "common").
`description`: Description of the Lambda function.

## Usage

1. Clone this repository:
   ```bash
   git clone <repository_url>
   ```
2. Change to the project directory:
   ```bash
   cd terraform/aws/examples/lambda
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
   ```
   
**Cleanup**

To destroy the created resources and clean up, run:

```bash
terraform destroy
```
