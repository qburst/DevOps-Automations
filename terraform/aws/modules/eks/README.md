# AWS EKS Cluster Terraform Project

This Terraform project sets up an Amazon Web Services (AWS) Elastic Kubernetes Service (EKS) cluster along with the necessary infrastructure components in your AWS environment.

## Project Structure

The project is organized into the following directories and files:

- **/DevOps-Automations/terraform/aws/modules/eks**: This directory contains the Terraform modules for setting up the EKS cluster and related infrastructure components.

  - `eks-node-group.tf`: Defines the EKS node group resources, including the IAM role, policies, and the node group itself.
  - `eks.tf`: Configures the EKS cluster, including IAM roles and policies.
  - `variables.tf`: Declares input variables used throughout the module.
  - `outputs.tf`: Defines the output values of the module.
  - `vpc.tf`:  Configures the VPC by calling the external VPC module and specifying input variables such as the CIDR blocks, subnets, availability zones, and NAT gateway settings.

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

**Variables for EKS Cluster Configuration**

`eks_cluster_name`: The name of the EKS cluster.
`eks_cluster_version`: The version of the EKS cluster.

**Variables for EKS Node Group Configuration**
`node_group_name`: The name of the EKS node group.
`node_group_desired_size`: Desired size of the node group.
`node_group_max_size`: Maximum size of the node group.
`node_group_min_size`: Minimum size of the node group.
`node_group_ami_type`: AMI type for the node group (e.g., AL2_x86_64).
`node_group_capacity_type`: Capacity type for the node group (e.g., ON_DEMAND).
`node_group_disk_size`: Disk size (in GB) for nodes in the group.
`node_group_instance_types`: List of instance types for the node group.
`node_group_labels`: Labels for the node group instances.
`node_group_version`: Version for the node group.
**Variables for VPC Configuration (Referencing External VPC Module)**
`vpc_cidr_block`: CIDR block for the VPC.
`private_subnet_cidr_blocks`: CIDR blocks for private subnets.
`public_subnet_cidr_blocks`: CIDR blocks for public subnets.
`availability_zones`: The various availability zones in which to create subnets.
`ipv4_additional_cidr`: Additional IPv4 CIDR blocks for association with the VPC.

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
6. List the cluster you have just created by running `terraform apply`:
   ```bash
   aws eks list-clusters
   ```
7. Configure kubectl:
   ```bash
    aws eks --region <region> update-kubeconfig --name <cluster-name>
    ```
8. To get the service :
   ```bash
   kubectl get svc
   ```
9. Deploy NGINX Web Application:
   ```bash
   kubectl apply -f app.yaml
   ```
10. Access the Application:
   
   After a few moments, you should be able to access the NGINX web application using the Load Balancer's DNS name or IP address.

11. Delete NGINX Pods and Service (Before Cleanup):
   ```bash
   kubectl delete -f app.yaml
   ```


**Cleanup**

To destroy the created resources and clean up, run:

```bash
terraform destroy
```