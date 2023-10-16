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

variable "node_group_name" {
  type        = string
  description = "Name of the EKS node group."
  default     = "nodes-general"
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
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}
variable "availability_zones" {
  type        = list(string)
  description = "the various AZs in which to create subnets"
  default     = []
}
variable "ipv4_additional_cidr" {
  type = list(string)
  default = [] 
}