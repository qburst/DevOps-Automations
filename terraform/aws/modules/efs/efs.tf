/*This will create EFS in bursting mode.The mode can be changed as per the requirement*/
resource "aws_efs_file_system" "elastic_file_system" {
  creation_token = var.creation_token

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode
}

