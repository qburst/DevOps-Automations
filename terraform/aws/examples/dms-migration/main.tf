data "aws_kms_key" "dms" {
  key_id = "alias/mng-kms-dms01"
}

data "aws_dms_replication_subnet_group" "trusted" {
  replication_subnet_group_id = "mng-dms-subnet-group-trusted01"
}

data "aws_security_group" "dms" {
  filter {
    name   = "tag:Name"
    values = ["mng-vpc-sg-default01"]
  }
}

locals {
  table_mappings = jsonencode({
    rules = [
      {
        rule-type = "selection"
        rule-id   = "1"
        rule-name = "include-all"
        object-locator = {
          schema-name = "%"
          table-name  = "%"
        }
        rule-action = "include"
      }
    ]
  })

  task_settings = jsonencode({
    FullLoadSettings = {
      TargetTablePrepMode = "DO_NOTHING"
    }
  })
}

# DMS migration: on-prem PostgreSQL (source) -> Aurora PostgreSQL in AWS (target).
# Endpoints are created by the module from the connection details below.
module "dms_migration" {
  source = "../../modules/dms-migration"

  replication_instance_id    = "mng-dms-replication-instance01"
  replication_instance_class = "dms.t3.medium"

  allocated_storage = 100
  engine_version    = "3.5.0"
  multi_az          = false

  replication_subnet_group_id = data.aws_dms_replication_subnet_group.trusted.replication_subnet_group_id
  vpc_security_group_ids      = [data.aws_security_group.dms.id]

  kms_key_arn = data.aws_kms_key.dms.arn

  maintenance_window          = "sun:04:00-sun:05:00"
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false
  apply_immediately           = false

  replication_task_id       = "mng-dms-task-cloudmigration-poc01"
  migration_type            = "full-load-and-cdc"
  table_mappings            = local.table_mappings
  replication_task_settings = local.task_settings

  # Source: on-prem PostgreSQL
  source_endpoint_id                 = "mng-dms-endpoint-source-onprem-postgres01"
  source_engine_name                 = "postgres"
  source_server_name                 = "onprem-db.example.internal"
  source_port                        = 5432
  source_database_name               = "myapp"
  source_username                    = "dms_user"
  source_password                    = "ChangeMeOnPrem123"
  source_ssl_mode                    = "require"
  source_extra_connection_attributes = ""

  # Target: Aurora PostgreSQL in AWS (use your Aurora cluster endpoint in production)
  target_endpoint_id                 = "mng-dms-endpoint-target-aurora01"
  target_engine_name                 = "aurora-postgresql"
  target_server_name                 = "mng-aurora-postgres-cloudmigration-poc01.xxxxx.ap-northeast-1.rds.amazonaws.com"
  target_port                        = 5432
  target_database_name               = "cloudmigration"
  target_username                    = "cloudmigration_admin"
  target_password                    = "ChangeMeAurora123"
  target_ssl_mode                    = "require"
  target_extra_connection_attributes = ""

  tags = {
    ManagedBy   = "terraform"
    Project     = "CloudMigration-PoC"
    Environment = "Type-Int"
  }
}


