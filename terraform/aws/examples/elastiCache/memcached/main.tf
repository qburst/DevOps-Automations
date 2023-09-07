module "memcached" {
	source               = "../../../modules/elastiCache/memcached"
	name	             = "qburst"
	environment          = "test"
	vpc_id               = "vpc-0ba7b0c7779403562"
	allowed_cidr         = ["10.51.0.0/16"]
	subnet_ids           = ["subnet-0422b72d95aa8c647", "subnet-0fe20129402323144", "subnet-0171e36d139e2aeab"]
	parameter_group_name = "memcached-pg"
	maintenance_window   = "sat:07:30-sat:08:30"
}

output "example_memcached_outputs" {
  value = module.memcached
}