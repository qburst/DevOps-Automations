output "replication_instance_arn" {
  description = "ARN of the DMS replication instance."
  value       = aws_dms_replication_instance.this.replication_instance_arn
}

output "replication_task_arn" {
  description = "ARN of the DMS replication task."
  value       = aws_dms_replication_task.this.replication_task_arn
}

output "replication_subnet_group_id" {
  description = "ID of the DMS replication subnet group in use (either provided or created by the module)."
  value       = var.replication_subnet_group_id != "" ? var.replication_subnet_group_id : aws_dms_replication_subnet_group.this[0].replication_subnet_group_id
}

output "source_endpoint_arn" {
  description = "ARN of the DMS source endpoint (either provided or created by the module)."
  value       = var.source_endpoint_arn != "" ? var.source_endpoint_arn : aws_dms_endpoint.source[0].endpoint_arn
}

output "target_endpoint_arn" {
  description = "ARN of the DMS target endpoint (either provided or created by the module)."
  value       = var.target_endpoint_arn != "" ? var.target_endpoint_arn : aws_dms_endpoint.target[0].endpoint_arn
}

