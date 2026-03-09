output "log_group_names" {
  description = "Names of the CloudWatch log groups created."
  value       = keys(aws_cloudwatch_log_group.this)
}

