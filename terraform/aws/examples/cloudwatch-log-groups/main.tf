data "aws_kms_key" "logs" {
  key_id = "alias/mng-kms-logs01"
}

module "cloudwatch_log_groups" {
  source = "../../modules/cloudwatch-log-groups"

  log_group_names = [
    "/ecs/cloudmigration-poc-app",
    "/rds/aurora-postgres/cloudmigration-poc",
    "/dms/cloudmigration-poc",
  ]

  kms_key_arn       = data.aws_kms_key.logs.arn
  retention_in_days = 30

  tags = {
    ManagedBy   = "terraform"
    Project     = "CloudMigration-PoC"
    Environment = "Type-Int"
  }
}

