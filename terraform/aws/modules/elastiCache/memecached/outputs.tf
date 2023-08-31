#To get cache node endpoints (for Memcached and Redis nodes)

output "cache_node_endpoint" {
  value = "${join(",", aws_elasticache_cluster.cache.cache_nodes.*.address)}"
}

# To get cluster configuration endpoint (for Memcached only)

output "cluster_configuration_endpoint" {
  value       = join("", aws_elasticache_cluster.cache[*].configuration_endpoint)
  description = "Cluster configuration endpoint"
}

output "port" {
  value = var.port
}
