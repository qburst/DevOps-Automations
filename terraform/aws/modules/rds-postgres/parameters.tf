resource "aws_rds_cluster_parameter_group" "this" {
  name        = "${var.identifier}-${replace(var.engine_version, ".", "-")}"
  family      = "aurora-postgresql${split(".", var.engine_version)[0]}"
  description = "Cluster parameter group for Aurora PostgreSQL"

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = merge(
    {
      Name = "${var.identifier}-${replace(var.engine_version, ".", "-")}"
    },
    var.tags
  )
}

resource "aws_db_parameter_group" "this" {
  name        = "${var.identifier}-${replace(var.engine_version, ".", "-")}"
  family      = "aurora-postgresql${split(".", var.engine_version)[0]}"
  description = "DB parameter group for Aurora PostgreSQL"

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = merge(
    {
      Name = "${var.identifier}-${replace(var.engine_version, ".", "-")}"
    },
    var.tags
  )
}
