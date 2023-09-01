#To get cache node endpoints 

output "cache_node_endpoint" {
  value = "${join(",", aws_elasticache_cluster.cache.cache_nodes.*.address)}"
}

# To get cluster configuration endpoint 

output "cluster_configuration_endpoint" {
  value       = aws_elasticache_cluster.cache.configuration_endpoint
  description = "Cluster configuration endpoint"
}

output "port" {
  value = var.port
}
