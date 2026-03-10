resource "aws_db_subnet_group" "this" {
  count      = var.db_subnet_group_name == "" ? 1 : 0
  name       = var.identifier
  subnet_ids = var.subnet_ids

  tags = merge(
    {
      Name = var.identifier
    },
    var.tags
  )
}
