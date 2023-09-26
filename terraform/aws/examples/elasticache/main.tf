module "elasticache" {
  source                    = "../../modules/elasticache"
  name                      = "qburst"
  environment               = "test"
  vpc_id                    = "vpc-0aaada0de503478d5"
  allowed_cidr              = ["10.51.0.0/16"]
  subnet_ids                = ["subnet-043f47df947e369ca", "subnet-055a33bbac0724bb4", "subnet-0bff946a98d3aac91"]
  parameter_group_name      = "memcached-pg"
  maintenance_window        = "sat:07:30-sat:08:30"
  engine                    = "memcached"
  replication_group_enabled = "enabled"
  port                      = 11211
  parameter_group_family    = "memcached1.6"
}

output "example_outputs" {
  value = module.elasticache
}
