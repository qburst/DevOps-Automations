# Create memcached cache cluster

resource "aws_elasticache_cluster" "memcached" {
  count                        = var.engine == "memcached" ? 1 : 0
  cluster_id                   = "${var.environment}-${var.name}"
  engine                       = var.engine
  engine_version               = var.engine_version
  node_type                    = var.instance_type
  num_cache_nodes              = var.cluster_size
  parameter_group_name         = aws_elasticache_parameter_group.cache_parameter_group.id
  subnet_group_name            = aws_elasticache_subnet_group.cache_subnet_group.id
  security_group_ids           = [aws_security_group.cache_sg.id]
  maintenance_window           = var.maintenance_window
  apply_immediately            = var.apply_immediately
  notification_topic_arn       = var.notification_topic_arn
  port                         = var.port
  az_mode                      = var.az_mode
  availability_zone            = var.availability_zone
  preferred_availability_zones = var.availability_zones
}

# Create Redis cache single node cluster

resource "aws_elasticache_cluster" "redis_node" {
  count                        = var.engine == "redis" && var.replication_group_enabled == "disabled" ? 1 : 0
  cluster_id                   = "${var.environment}-${var.name}-node"
  engine                       = var.engine
  engine_version               = var.redis_version
  node_type                    = var.instance_type
  num_cache_nodes              = var.cluster_size
  parameter_group_name         = aws_elasticache_parameter_group.cache_parameter_group.id
  subnet_group_name            = aws_elasticache_subnet_group.cache_subnet_group.id
  security_group_ids           = [aws_security_group.cache_sg.id]
  maintenance_window           = var.maintenance_window
  apply_immediately            = var.apply_immediately
  notification_topic_arn       = var.notification_topic_arn
  port                         = var.port
  az_mode                      = var.az_mode
  availability_zone            = var.availability_zone
  preferred_availability_zones = var.availability_zones
}

# Create Redis cache cluster

resource "aws_elasticache_replication_group" "redis" {
  count                       = var.engine == "redis" && var.replication_group_enabled == "enabled" ? 1 : 0
  replication_group_id        = "${var.environment}-${var.name}"
  description                 = "Terraform-managed ElastiCache replication group for ${var.environment}-${var.name}"
  num_cache_clusters          = var.cluster_size
  node_type                   = var.instance_type
  automatic_failover_enabled  = var.redis_failover
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  preferred_cache_cluster_azs = var.availability_zones
  multi_az_enabled            = var.multi_az_enabled
  engine                      = var.engine
  at_rest_encryption_enabled  = var.at_rest_encryption_enabled
  kms_key_id                  = var.kms_key_id
  transit_encryption_enabled  = var.transit_encryption_enabled
  auth_token                  = var.transit_encryption_enabled ? var.auth_token : null
  engine_version              = var.redis_version
  port                        = var.port
  parameter_group_name        = aws_elasticache_parameter_group.cache_parameter_group.id
  subnet_group_name           = aws_elasticache_subnet_group.cache_subnet_group.id
  security_group_names        = var.security_group_names
  security_group_ids          = [aws_security_group.cache_sg.id]
  snapshot_arns               = var.snapshot_arns
  snapshot_name               = var.snapshot_name
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window
  notification_topic_arn      = var.notification_topic_arn
  snapshot_window             = var.redis_snapshot_window
  snapshot_retention_limit    = var.redis_snapshot_retention_limit
}


# Create parameter group for cache cluster

resource "aws_elasticache_parameter_group" "cache_parameter_group" {
  name   = var.parameter_group_name
  family = var.parameter_group_family
}

# Create cache subnet group

resource "aws_elasticache_subnet_group" "cache_subnet_group" {
  name        = "${var.environment}-${var.name}-cache"
  description = "Group of ${var.environment} cache subnets"
  subnet_ids  = var.subnet_ids
}

# Create cache security group

resource "aws_security_group" "cache_sg" {
  name        = "${var.environment}-${var.name}-cache_sg"
  description = "security group allowing egress for client-vpn users"
  vpc_id      = var.vpc_id
}

# Create security group rule for inbound traffic from VPC

resource "aws_security_group_rule" "cache_networks_ingress" {
  description       = "Allow ports for vpc"
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr
  security_group_id = aws_security_group.cache_sg.id
}

# Create security group rule for outbound traffic from Cache cluster

resource "aws_security_group_rule" "cache_egress_world" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cache_sg.id
}
