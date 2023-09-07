# Create cache cluster

resource "aws_elasticache_cluster" "cache" {
    cluster_id                     = "${var.environment}-${var.name}"
    engine                         = var.engine
    engine_version                 = var.engine_version
    node_type                      = var.instance_type
    num_cache_nodes                = var.cluster_size
    parameter_group_name           = aws_elasticache_parameter_group.cache_parameter_group.id
    subnet_group_name              = "${aws_elasticache_subnet_group.cache_subnet_group.id}"
    security_group_ids             = [aws_security_group.cache-sg.id]
    maintenance_window             = var.maintenance_window
    apply_immediately              = var.apply_immediately
    notification_topic_arn         = var.notification_topic_arn
    port                           = var.port
    az_mode                        = var.az_mode
    availability_zone              = var.availability_zone
    preferred_availability_zones   = var.availability_zones
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

resource "aws_security_group" "cache-sg" {
    name = "${var.environment}-${var.name}-cache-sg"
    description = "security group allowing egress for client-vpn users"
    vpc_id      = var.vpc_id
}

# Create security group rule for inbound traffic from VPC

resource "aws_security_group_rule" "cache_networks_ingress" {
    description              = "Allow ports for vpc"
    type                     = "ingress"
    from_port                = var.port
    to_port                  = var.port
    protocol                 = "tcp"
    cidr_blocks              = var.allowed_cidr
    security_group_id        = aws_security_group.cache-sg.id
}

# Create security group rule for outbound traffic from Cache cluster

resource "aws_security_group_rule" "cache_egress_world" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.cache-sg.id
}
