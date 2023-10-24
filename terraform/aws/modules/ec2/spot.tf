resource "aws_spot_instance_request" "default" {
  count                          = var.spot_instance_enabled ? var.spot_instance_count : 0
  spot_price                     = var.spot_price
  wait_for_fulfillment           = var.spot_wait_for_fulfillment
  spot_type                      = var.spot_type
  launch_group                   = var.spot_launch_group
  block_duration_minutes         = var.spot_block_duration_minutes
  instance_interruption_behavior = var.spot_instance_interruption_behavior
  valid_until                    = var.spot_valid_until
  valid_from                     = var.spot_valid_from
  ami                            = var.ami == "" ? data.aws_ami.ubuntu.id : var.ami
  ebs_optimized                  = var.ebs_optimized
  instance_type                  = var.instance_type
  key_name                       = var.ssh_key.key_name == "" ? join("", aws_key_pair.default[*].key_name) : var.ssh_key.key_name
  monitoring                     = var.monitoring
  vpc_security_group_ids         = length(var.sg_ids) < 1 ? aws_security_group.default[*].id : var.sg_ids
  subnet_id                      = element(distinct(compact(concat(var.subnet_ids))), count.index)
  associate_public_ip_address    = var.associate_public_ip_address
  disable_api_termination        = var.disable_api_termination
  tenancy                        = var.tenancy
  host_id                        = var.host_id
  cpu_core_count                 = var.cpu_core_count
  cpu_threads_per_core           = var.cpu_threads_per_core
  user_data                      = var.user_data
  user_data_replace_on_change    = var.user_data_replace_on_change
  availability_zone              = var.availability_zone
  get_password_data              = var.get_password_data
  private_ip                     = var.private_ip
  secondary_private_ips          = var.secondary_private_ips
  iam_instance_profile           = join("", aws_iam_instance_profile.default[*].name)
  source_dest_check              = var.source_dest_check
  ipv6_address_count             = var.ipv6_address_count
  ipv6_addresses                 = var.ipv6_addresses

  dynamic "cpu_options" {
    for_each = length(var.cpu_options) > 0 ? [var.cpu_options] : []
    content {
      core_count       = lookup(cpu_options, "core_count", null)
      threads_per_core = lookup(cpu_options, "threads_per_core", null)
      amd_sev_snp      = lookup(cpu_options, "amd_sev_snp", null)
    }
  }

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = true
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = var.kms_key_id == "" ? join("", aws_kms_key.default[*].arn) : lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      tags = {
        Name = "${var.instance_name}-${count.index}-root-volume"
      }
    }
  }

  tags = {
    Name = "${var.instance_name}-${count.index}-root-volume"
  }
  lifecycle {
    ignore_changes = [
      private_ip, associate_public_ip_address
    ]
  }
}
