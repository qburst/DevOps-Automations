locals {
  
  subnet_ids_provided           = var.subnet_ids != null && length(var.subnet_ids) > 0
  db_subnet_group_name_provided = var.db_subnet_group_name != null && var.db_subnet_group_name != ""
  is_replica                    = try(length(var.replicate_source_db), 0) > 0

  db_subnet_group_name = local.db_subnet_group_name_provided ? var.db_subnet_group_name : (
    local.is_replica ? null : (
    local.subnet_ids_provided ? join("", aws_db_subnet_group.default.*.name) : null)
  )

  availability_zone = var.multi_az ? null : var.availability_zone
}


resource "random_password" "db-password" {
  count = local.is_replica ? 0:1

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_kms_key" "db_ssm_encrypt" {
  count = local.is_replica ? 0:1   
  description             = "KMS key for database parameter-store encryption"
  enable_key_rotation     = true
  tags                    = {
           Name = "${var.tagname}-rds-ssm-kms-key"
     }
}

resource "aws_ssm_parameter" "db-password" {
  count = local.is_replica ? 0:1   
  name        = "/${var.tagname}/DATABASE_PASSWORD"
  description = "SSM Parameter for database password"
  type        = "SecureString"
  value       = random_password.db-password[count.index].result
  key_id      = aws_kms_key.db_ssm_encrypt[count.index].arn

  tags = {
     Name = "${var.tagname}-dbpassword"
  }
}


resource "aws_db_instance" "default" {

  count = var.enabled ? 1 : 0 
  
  identifier                  = var.db-identifier
  db_name                     = var.database_name
  username                    = local.is_replica ? null : var.database_user
  password                    = local.is_replica ? null : aws_ssm_parameter.db-password[count.index].value
  port                        = var.database_port
  engine                      = local.is_replica ? null : var.engine
  engine_version              = local.is_replica ? null : var.engine_version
  character_set_name          = var.charset_name
  instance_class              = var.instance_class
  allocated_storage           = local.is_replica ? null : var.allocated_storage
  max_allocated_storage       = var.max_allocated_storage
  storage_encrypted           = var.storage_encrypted
  kms_key_id                  = var.kms_key_arn
  db_subnet_group_name        = local.db_subnet_group_name
  availability_zone           = local.availability_zone
  ca_cert_identifier          = var.ca_cert_identifier
  parameter_group_name        = var.parameter_group_name
  option_group_name           = var.option_group_name
  license_model               = var.license_model
  multi_az                    = var.multi_az
  storage_type                = var.storage_type
  iops                        = var.iops
  storage_throughput          = var.storage_type == "gp3" ? var.storage_throughput : null
  publicly_accessible         = var.publicly_accessible
  snapshot_identifier         = var.snapshot_identifier
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window
  skip_final_snapshot         = var.skip_final_snapshot
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  backup_retention_period     = var.backup_retention_period
  backup_window               = var.backup_window
  
  deletion_protection         = var.deletion_protection
  replicate_source_db         = var.replicate_source_db
  timezone                    = var.timezone
    vpc_security_group_ids = compact(
    concat(
      [join("", aws_security_group.default.*.id)],
      var.associate_security_group_ids
    )
  )

    tags = {
      Name = "${var.tagname}-rds"
      }


  iam_database_authentication_enabled   = var.iam_database_authentication_enabled
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.performance_insights_kms_key_id : null
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  depends_on = [
    aws_db_subnet_group.default,
    aws_security_group.default,

  ]

  lifecycle {
    ignore_changes = [
      snapshot_identifier, # if created from a snapshot, will be non-null at creation, but null afterwards
    ]
  }

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

}

  resource "aws_db_subnet_group" "default" {
  count = local.subnet_ids_provided && !local.db_subnet_group_name_provided ? 1 : 0
  subnet_ids = var.subnet_ids
  
}

resource "aws_security_group" "default" {
 

  name        = "${var.tagname}-rds-security"
  description = "Allow inbound traffic from the security groups"
  vpc_id      = var.vpc_id
  tags        =  {
           Name = "${var.tagname}-sg-rds"
     }
}

resource "aws_security_group_rule" "ingress_security_groups" {
  count = length(var.security_group_ids) > 0 ? 1 : 0
  
  description              = "Allow inbound traffic from existing Security Groups"
  type                     = "ingress"
  from_port                = var.database_port
  to_port                  = var.database_port
  protocol                 = "tcp"
  source_security_group_id = var.security_group_ids[count.index]
  security_group_id        = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  count = length(var.allowed_cidr_blocks) > 0 ? 1 : 0

  description       = "Allow inbound traffic from CIDR blocks"
  type              = "ingress"
  from_port         = var.database_port
  to_port           = var.database_port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "egress" {

  description       = "Allow all egress traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}

