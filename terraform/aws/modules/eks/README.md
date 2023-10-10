# AWS EKS Cluster Terraform Project

This Terraform project sets up an Amazon Web Services (AWS) Elastic Kubernetes Service (EKS) cluster along with the necessary infrastructure components in your AWS environment.

## Project Structure

The project is organized into the following directories and files:

- **/DevOps-Automations/terraform/aws/modules/eks**: This directory contains the Terraform modules for setting up the EKS cluster and related infrastructure components.

  - `eks-node-group.tf`: Defines the EKS node group resources, including the IAM role, policies, and the node group itself.
  - `eks.tf`: Configures the EKS cluster, including IAM roles and policies.
  - `vpc.tf`: Defines the AWS Virtual Private Cloud (VPC) and its configuration.
  - `subnets.tf`: Configures the subnets used by the EKS cluster.
  - `igw.tf`: Sets up the AWS Internet Gateway.
  - `nat.tf`: Configures the Network Address Translation (NAT) Gateway.
  - `routes.tf`: Defines the routing tables for private and public subnets.
  - `variables.tf`: Declares input variables used throughout the module.
  - `outputs.tf`: Defines the output values of the module.

- **/DevOps-Automations/terraform/aws/examples/eks**: This directory contains example configurations that use the EKS module defined in the `modules/eks` directory.

  - `provider.tf`: Configures the Terraform provider for AWS and specifies the default AWS region.
  - `main.tf`: Calls the EKS module and passes input variables to create an EKS cluster and its associated infrastructure.
  - `app.yaml`:YAML file for deploying a sample NGINX web application in the EKS cluster.


## Prerequisites

Before using this Terraform configuration, ensure you have the following prerequisites:

1. [Terraform](https://www.terraform.io/) (v1.5.0 or later) installed.
2. AWS CLI configured with appropriate access credentials.
3. [kubectl](https://kubernetes.io/docs/tasks/tools/) (or managing the EKS cluster).

## Configuration
You can customize the configuration by modifying the input variables in the main.tf file. The following are the available input variables:

  `vpc_cidr_block`: The CIDR block for the VPC.
  `igw_name`: The name for the Internet Gateway.
  `private_subnet_cidr_blocks`: A list of CIDR blocks for the private subnets.
  `public_subnet_cidr_blocks`: A list of CIDR blocks for the public subnets.
  `nat_gateway_name`: The name for the NAT Gateway.
  `eks_cluster_name`: The name for the EKS cluster.

Please adjust these variables to match your specific requirements.

## Usage

To use this Terraform project, follow these steps:

1. Clone this repository:
   ```bash
   git clone <repository_url>
   ```
2. Change to the project directory:
   ```bash
   cd terraform/aws/examples/eks
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
6. Configure kubectl:
   ```bash
    aws eks --region <region> update-kubeconfig --name <cluster-name>
    ```
7. Deploy NGINX Web Application:
   ```bash
   kubectl apply -f app.yaml
   ```
8. Access the Application:
   After a few moments, you should be able to access the NGINX web application using the Load Balancer's DNS name or IP address.
   

**Cleanup**

To destroy the created resources and clean up, run:

```bash
terraform destroy
```