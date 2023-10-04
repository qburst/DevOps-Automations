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
  description = "Name for the EKS Cluster"
  type        = string
  default     = "demo"
}
variable "eks_node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "nodes-general"
}
