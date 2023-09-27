output "efs_id" {
  value       = aws_efs_file_system.elastic_file_system.id
  description = "The ID of the EFS created"
}
output "efs_arn" {
  value       = aws_efs_file_system.elastic_file_system.arn
  description = "The ARN of the EFS created"
}