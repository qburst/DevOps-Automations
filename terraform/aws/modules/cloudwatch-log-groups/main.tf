resource "aws_cloudwatch_log_group" "this" {
  for_each = toset(var.log_group_names)

  name              = each.value
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_arn

  tags = merge(
    {
      Name = each.value
    },
    var.tags
  )
}

