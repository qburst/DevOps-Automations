resource "aws_dms_replication_subnet_group" "this" {
  count = var.replication_subnet_group_id == "" ? 1 : 0

  replication_subnet_group_id          = "${var.replication_instance_id}-subnet-group"
  replication_subnet_group_description = "DMS replication subnet group for ${var.replication_instance_id}"
  subnet_ids                           = var.subnet_ids

  tags = merge(
    {
      Name = "${var.replication_instance_id}-subnet-group"
    },
    var.tags
  )
}
