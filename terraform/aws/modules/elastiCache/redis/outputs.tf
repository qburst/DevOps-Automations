output "redis_security_group_id" {
  value = aws_security_group.redis_sg.id
}

output "parameter_group" {
  value = aws_elasticache_parameter_group.redis_parameter_group.id
}

output "redis_subnet_group_name" {
  value = aws_elasticache_subnet_group.redis_subnet_group.name
}

output "port" {
  value = var.redis_port
}

output "primary_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "reader_endpoint_address" {
  value       = join("", compact(aws_elasticache_replication_group.redis[*].reader_endpoint_address))
  description = "The address of the endpoint for the reader node in the replication group, if the cluster mode is disabled."
}

# To get Endpoint for  Redis cache single node cluster

# output "cache_node_endpoint" {
#   value = "${join(",", aws_elasticache_cluster.redis_node.cache_nodes.*.address)}"
# }
