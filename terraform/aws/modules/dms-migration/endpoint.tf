resource "aws_dms_endpoint" "source" {
  count = var.source_endpoint_arn != "" ? 0 : 1

  endpoint_id   = var.source_endpoint_id
  endpoint_type = "source"
  engine_name   = var.source_engine_name

  server_name   = var.source_server_name
  port          = var.source_port
  database_name = var.source_database_name
  username      = var.source_username
  password      = var.source_password

  ssl_mode                    = var.source_ssl_mode
  extra_connection_attributes = var.source_extra_connection_attributes

  tags = merge(
    {
      Name = var.source_endpoint_id
    },
    var.tags
  )
}

resource "aws_dms_endpoint" "target" {
  count = var.target_endpoint_arn != "" ? 0 : 1

  endpoint_id   = var.target_endpoint_id
  endpoint_type = "target"
  engine_name   = var.target_engine_name

  server_name   = var.target_server_name
  port          = var.target_port
  database_name = var.target_database_name
  username      = var.target_username
  password      = var.target_password

  ssl_mode                    = var.target_ssl_mode
  extra_connection_attributes = var.target_extra_connection_attributes

  tags = merge(
    {
      Name = var.target_endpoint_id
    },
    var.tags
  )
}
