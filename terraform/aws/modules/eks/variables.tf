variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "igw_name" {
  description = "Name for the Internet Gateway"
  type        = string
  default     = "qburst-igw"
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.96.0/19"]
}

variable "nat_gateway_name" {
  description = "Name for the NAT Gateway"
  type        = string
  default     = "nat"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster."
  default     = "my-eks-cluster"
}

variable "eks_cluster_version" {
  type        = string
  description = "Version of the EKS cluster."
  default     = "1.24"
}

variable "eks_cluster_region" {
  type        = string
  description = "AWS region for the EKS cluster."
  default     = "us-east-1"
}

variable "node_group_name" {
  type        = string
  description = "Name of the EKS node group."
  default     = "nodes-general"
}

variable "node_group_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the node group."
  default     = ["subnet-06296791b48518207",
                "subnet-09b57ef336acf2868",
                "subnet-0bf698a94602fa750",
                "subnet-086708cfd5a439019"
]
}

variable "node_group_desired_size" {
  type        = number
  description = "Desired size of the node group."
  default     = 1
}

variable "node_group_max_size" {
  type        = number
  description = "Maximum size of the node group."
  default     = 2
}

variable "node_group_min_size" {
  type        = number
  description = "Minimum size of the node group."
  default     = 1
}

variable "node_group_ami_type" {
  type        = string
  description = "AMI type for the node group (e.g., AL2_x86_64)."
  default     = "AL2_x86_64"
}

variable "node_group_capacity_type" {
  type        = string
  description = "Capacity type for the node group (e.g., ON_DEMAND)."
  default     = "ON_DEMAND"
}

variable "node_group_disk_size" {
  type        = number
  description = "Disk size (in GB) for nodes in the group."
  default     = 20
}

variable "node_group_instance_types" {
  type        = list(string)
  description = "List of instance types for the node group."
  default     = ["t3.small"]
}

variable "node_group_labels" {
  type        = map(string)
  description = "Labels for the node group instances."
  default     = { role = "nodes_general" }
}

variable "node_group_version" {
  type        = string
  description = "Version for the node group."
  default     = "1.24"
}




