# Create redis cluster

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.environment}-${var.name}"
  description = "Terraform-managed ElastiCache replication group for ${var.environment}-${var.name}"
  num_cache_clusters            = var.num_cache_clusters
  node_type                     = var.redis_node_type
  automatic_failover_enabled    = var.redis_failover
  auto_minor_version_upgrade    = var.auto_minor_version_upgrade
  preferred_cache_cluster_azs   = var.availability_zones
  multi_az_enabled              = var.multi_az_enabled
  engine                        = "redis"
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  kms_key_id                    = var.kms_key_id
  transit_encryption_enabled    = var.transit_encryption_enabled
  auth_token                    = var.transit_encryption_enabled ? var.auth_token : null
  engine_version                = var.redis_version
  port                          = var.redis_port
  parameter_group_name          = aws_elasticache_parameter_group.redis_parameter_group.id
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.id
  security_group_names          = var.security_group_names
  security_group_ids            = [aws_security_group.redis_sg.id]
  snapshot_arns                 = var.snapshot_arns
  snapshot_name                 = var.snapshot_name
  apply_immediately             = var.apply_immediately
  maintenance_window            = var.redis_maintenance_window
  notification_topic_arn        = var.notification_topic_arn
  snapshot_window               = var.redis_snapshot_window
  snapshot_retention_limit      = var.redis_snapshot_retention_limit
#   num_node_groups               = var.num_node_groups
#   replicas_per_node_group       = var.replicas_per_node_group
}

# Create parameter group for redis cluster

resource "aws_elasticache_parameter_group" "redis_parameter_group" {
    name   = var.parameter_group_name
    family = var.parameter_group_family
}

# Create subnet group for redis cluster

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
    name        = "${var.environment}-${var.name}-redis-cache"
    description = "Group of ${var.environment} cache subnets"
    subnet_ids  = var.subnet_ids
}

# Create security group for redis cluster

resource "aws_security_group" "redis_sg" {
    name        = "${var.environment}-${var.name}-redis-sg"
    description = "security group allowing egress for client-vpn users"
    vpc_id      = var.vpc_id
}

# Create security group rule for inbound traffic from VPC

resource "aws_security_group_rule" "redis_ingress" {
    description              = "Allow ports for vpc"
    type                     = "ingress"
    from_port                = var.redis_port
    to_port                  = var.redis_port
    protocol                 = "tcp"
    cidr_blocks              = var.allowed_cidr
    security_group_id        = aws_security_group.redis_sg.id
}

# Create security group rule for outbound traffic from Cache cluster

resource "aws_security_group_rule" "redis_egress_world" {
    description       = "Allow outbound traffic"
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.redis_sg.id
}


# Create Redis cache single node cluster

# resource "aws_elasticache_cluster" "redis_node" {
#     cluster_id                     = "${var.environment}-${var.name}-node"
#     engine                         = "redis"
#     engine_version                 = var.redis_version
#     node_type                      = var.redis_node_type
#     num_cache_nodes                = var.redis_num_cache_nodes
#     parameter_group_name           = aws_elasticache_parameter_group.redis_parameter_group.id
#     subnet_group_name              = "${aws_elasticache_subnet_group.redis_subnet_group.id}"
#     security_group_ids             = [aws_security_group.redis_sg.id]
#     maintenance_window             = var.redis_maintenance_window
#     apply_immediately              = var.apply_immediately
#     notification_topic_arn         = var.notification_topic_arn
#     port                           = var.redis_port
#     az_mode                        = var.az_mode
#     availability_zone              = var.availability_zone
#     preferred_availability_zones   = var.availability_zones
# }
