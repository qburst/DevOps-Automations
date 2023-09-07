module "memcached" {
	source               = "../../modules/elastiCache/memcached"
	name	             = "qburst"
	environment          = "test"
	vpc_id               = "vpc-0441fce0c2492c186"
	allowed_cidr         = ["10.51.0.0/16"]
	subnet_ids           = ["subnet-010042383f971ee48", "subnet-08cc74de2a32f6f50", "subnet-0d603c3ee329c1005"]
	parameter_group_name = "memcached1.6-pg"
	maintenance_window   = "sat:07:30-sat:08:30"
}
