module "redis" {
	source               = "../../modules/elastiCache/redis"
	name                 = "qburst"
	environment          = "test"
	vpc_id               = "vpc-0441fce0c2492c186"
	allowed_cidr         = ["10.51.0.0/16"]
	subnet_ids           = ["subnet-010042383f971ee48", "subnet-08cc74de2a32f6f50", "subnet-0d603c3ee329c1005"]
	redis_version        = "3.2.10"
	num_cache_clusters   = 1
	redis_node_type      = "cache.t3.micro"
	parameter_group_name = "redis3.2-pg"
}
