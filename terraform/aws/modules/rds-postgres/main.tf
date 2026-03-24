resource "aws_rds_cluster" "this" {
  cluster_identifier = var.identifier

  engine         = "aurora-postgresql"
  engine_version = var.engine_version
  engine_mode    = var.engine_mode

  database_name   = var.db_name
  master_username = var.username
  master_password = var.password

  db_subnet_group_name   = var.db_subnet_group_name != "" ? var.db_subnet_group_name : aws_db_subnet_group.this[0].name
  vpc_security_group_ids = var.vpc_security_group_ids

  storage_encrypted = true
  kms_key_id        = var.kms_key_id

  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.backup_window
  preferred_maintenance_window = var.maintenance_window

  deletion_protection = var.deletion_protection
  apply_immediately   = var.apply_immediately

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier != "" ? var.final_snapshot_identifier : var.identifier

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name

  copy_tags_to_snapshot = true

  dynamic "scaling_configuration" {
    for_each = var.engine_mode == "serverless" ? [1] : []
    content {
      auto_pause               = var.serverless_auto_pause
      min_capacity             = var.serverless_min_capacity
      max_capacity             = var.serverless_max_capacity
      seconds_until_auto_pause = var.serverless_seconds_until_auto_pause
    }
  }

  tags = merge(
    {
      Name = var.identifier
    },
    var.tags
  )
}

resource "aws_rds_cluster_instance" "rds_instance" {
  count = var.engine_mode == "provisioned" ? var.instance_count : 0

  identifier         = "${var.identifier}-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.this.id

  engine         = aws_rds_cluster.this.engine
  engine_version = aws_rds_cluster.this.engine_version

  instance_class = var.instance_class

  publicly_accessible     = false
  db_subnet_group_name    = var.db_subnet_group_name != "" ? var.db_subnet_group_name : aws_db_subnet_group.this[0].name
  db_parameter_group_name = aws_db_parameter_group.this.name

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  tags = merge(
    {
      Name = "${var.identifier}-${count.index + 1}"
    },
    var.tags
  )
}
