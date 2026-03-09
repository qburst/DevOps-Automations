resource "aws_dms_replication_instance" "this" {
  replication_instance_id      = var.replication_instance_id
  replication_instance_class   = var.replication_instance_class
  allocated_storage            = var.allocated_storage
  engine_version               = var.engine_version
  multi_az                     = var.multi_az
  publicly_accessible          = false
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  allow_major_version_upgrade  = var.allow_major_version_upgrade
  apply_immediately            = var.apply_immediately
  replication_subnet_group_id  = var.replication_subnet_group_id != "" ? var.replication_subnet_group_id : aws_dms_replication_subnet_group.this[0].replication_subnet_group_id
  vpc_security_group_ids       = var.vpc_security_group_ids
  kms_key_arn                  = var.kms_key_arn
  preferred_maintenance_window = var.maintenance_window
  tags = merge(
    {
      Name = var.replication_instance_id
    },
    var.tags
  )
}

resource "aws_dms_replication_task" "this" {
  replication_task_id       = var.replication_task_id
  migration_type            = var.migration_type
  replication_instance_arn  = aws_dms_replication_instance.this.replication_instance_arn
  source_endpoint_arn       = var.source_endpoint_arn != "" ? var.source_endpoint_arn : aws_dms_endpoint.source[0].endpoint_arn
  target_endpoint_arn       = var.target_endpoint_arn != "" ? var.target_endpoint_arn : aws_dms_endpoint.target[0].endpoint_arn
  table_mappings            = var.table_mappings
  replication_task_settings = var.replication_task_settings

  tags = merge(
    {
      Name = var.replication_task_id
    },
    var.tags
  )
}

