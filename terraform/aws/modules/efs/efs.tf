/*This will create EFS in bursting mode.The mode can be changed as per the requirement*/
resource "aws_efs_file_system" "elastic_file_system" {
  creation_token = var.creation_token

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  encrypted        = var.encryption_set
  kms_key_id       = aws_kms_key.kms_key_efs.arn
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode
}

# Define the EFS mount target (optional)
resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id  = aws_efs_file_system.elastic_file_system.id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
}
# KMS Key for EFS
resource "aws_kms_key" "kms_key_efs" {
  description         = "KMS key for EFS"
  enable_key_rotation = true
}