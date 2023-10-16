output "eks_cluster_id" {
  value       = aws_eks_cluster.demo.id
  description = "The ID of the EKS cluster"
}

output "node_group_id" {
  value       = aws_eks_node_group.nodes_general.id
  description = "The ID of the EKS node group"
}
