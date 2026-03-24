module "rds_postgres" {
  source = "../../modules/rds-postgres"

  identifier = "mng-aurora-postgres-cloudmigration-poc01"

  engine_version = "16.5"
  engine_mode    = "provisioned"

  instance_class = "db.t4g.micro"
  instance_count = 2

  db_name  = "cloudmigration"
  username = "cloudmigration_admin"
  password = "ChangeMe123!"

  subnet_ids             = ["subnet-123", "subnet-234"]
  vpc_security_group_ids = ["sec-grp-5432"]

  kms_key_id = "arn:aws:kms:ap-northeast-1:123456789012:key/key-id"

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"
  multi_az                = false

  deletion_protection       = true
  skip_final_snapshot       = false
  final_snapshot_identifier = "mng-aurora-postgres-cloudmigration-poc01-final"

  auto_minor_version_upgrade = true
  apply_immediately          = false

  tags = {
    ManagedBy   = "terraform"
    Project     = "CloudMigration-PoC"
    Environment = "Type-Int"
  }
}
