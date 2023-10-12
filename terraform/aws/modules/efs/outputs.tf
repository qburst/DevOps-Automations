output "efs_id" {
  value       = aws_efs_file_system.elastic_file_system.id
  description = "The ID of the EFS created"
}
output "efs_arn" {
  value       = aws_efs_file_system.elastic_file_system.arn
  description = "The ARN of the EFS created"
}
output "efs_mount_id" {
  value       = aws_efs_mount_target.efs_mount_target[*].id
  description = "The IDs of the EFS mount"
}