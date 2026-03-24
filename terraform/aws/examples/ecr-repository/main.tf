data "aws_kms_key" "ecr" {
  key_id = "alias/mng-kms-ecr01"
}

module "ecr_repository" {
  source = "../../modules/ecr-repository"

  name        = "mng-ecr-cloudmigration-poc-app01"
  kms_key_arn = data.aws_kms_key.ecr.arn

  scan_on_push         = true
  image_tag_mutability = "IMMUTABLE"

  tags = {
    ManagedBy   = "terraform"
    Project     = "CloudMigration-PoC"
    Environment = "Type-Int"
  }
}

