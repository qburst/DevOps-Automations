output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "igw_id" {
  description = "ID of the created Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = [aws_subnet.private_us_east_1a.id, aws_subnet.private_us_east_1b.id]
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = [aws_subnet.public_us_east_1a.id, aws_subnet.public_us_east_1b.id]
}

output "nat_gateway_id" {
  description = "ID of the created NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "eks_cluster_id" {
  description = "ID of the created EKS Cluster"
  value       = aws_eks_cluster.demo.id
}
