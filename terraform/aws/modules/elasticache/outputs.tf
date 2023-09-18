# To get memcached cluster configuration endpoint 

output "memcached_cluster_configuration_endpoint" {
  value = var.engine == "memcached" ? aws_elasticache_cluster.memcached[0].configuration_endpoint : null
}


# To get primary endpoint for  Redis cache replication group cluster

output "redis_primary_endpoint" {
  value = var.engine == "redis" && var.replication_group_enabled == "enabled" ? aws_elasticache_replication_group.redis[0].primary_endpoint_address : null
}

# # To get reader endpoint for  Redis cache replication group cluster

output "redis_reader_endpoint_address" {
  value = var.engine == "redis" && var.replication_group_enabled == "enabled" ? aws_elasticache_replication_group.redis[*].reader_endpoint_address : null
}

# # To get Endpoint for Redis cache single node cluster

output "redis_node_endpoint" {
  value = var.engine == "redis" && var.replication_group_enabled == "disabled" ? aws_elasticache_cluster.redis_node[0].cache_nodes.*.address : null
}


output "security_group_id" {
  value = aws_security_group.cache_sg.id
}

output "parameter_group" {
  value = aws_elasticache_parameter_group.cache_parameter_group.id
}

output "subnet_group_name" {
  value = aws_elasticache_subnet_group.cache_subnet_group.name
}

output "port" {
  value = var.port
}
