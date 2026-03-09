output "cluster_arn" {
  description = "ARN of the Aurora PostgreSQL cluster."
  value       = aws_rds_cluster.this.arn
}

output "cluster_id" {
  description = "ID of the Aurora PostgreSQL cluster."
  value       = aws_rds_cluster.this.id
}

output "cluster_endpoint" {
  description = "Writer endpoint for the Aurora PostgreSQL cluster."
  value       = aws_rds_cluster.this.endpoint
}

output "cluster_reader_endpoint" {
  description = "Reader endpoint for the Aurora PostgreSQL cluster."
  value       = aws_rds_cluster.this.reader_endpoint
}

output "port" {
  description = "Port the database is listening on."
  value       = aws_rds_cluster.this.port
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group."
  value       = var.db_subnet_group_name != "" ? var.db_subnet_group_name : aws_db_subnet_group.this[0].name
}

output "cluster_parameter_group_name" {
  description = "Name of the RDS cluster parameter group."
  value       = aws_rds_cluster_parameter_group.this.name
}

output "db_parameter_group_name" {
  description = "Name of the DB parameter group."
  value       = aws_db_parameter_group.this.name
}
