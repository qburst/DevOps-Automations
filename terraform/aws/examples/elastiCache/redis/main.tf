module "redis" {
	source               = "../../../modules/elastiCache/redis"
	name                 = "qburst"
	environment          = "test"
	vpc_id               = "vpc-0ba7b0c7779403562"
	allowed_cidr         = ["10.51.0.0/16"]
	subnet_ids           = ["subnet-0422b72d95aa8c647", "subnet-0fe20129402323144", "subnet-0171e36d139e2aeab"]
	redis_version        = "3.2.10"
	num_cache_clusters   = 1
	redis_node_type      = "cache.t3.micro"
	parameter_group_name = "redis-pg"
}

output "example_redis_outputs" {
  value = module.redis
}