resource "aws_security_group" "default" {
  count       = var.enable_security_group && length(var.sg_ids) < 1 ? 1 : 0
  name        = "${var.instance_name}-sg"
  vpc_id      = var.vpc_id
  description = var.sg_description
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "${var.instance_name}-sg"
  }
}

resource "aws_security_group_rule" "egress_ipv4" {
  count             = (var.enable_security_group && length(var.sg_ids) < 1 && var.is_external == false && var.egress_rule) ? 1 : 0
  description       = var.sg_egress_description
  type              = "egress"
  from_port         = var.egress_ipv4_from_port
  to_port           = var.egress_ipv4_to_port
  protocol          = var.egress_ipv4_protocol
  cidr_blocks       = var.egress_ipv4_cidr_block
  security_group_id = join("", aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "egress_ipv6" {
  count             = var.enable_security_group && length(var.sg_ids) < 1 && var.is_external == false && var.egress_rule ? 1 : 0
  description       = var.sg_egress_ipv6_description
  type              = "egress"
  from_port         = var.egress_ipv6_from_port
  to_port           = var.egress_ipv6_to_port
  protocol          = var.egress_ipv6_protocol
  ipv6_cidr_blocks  = var.egress_ipv6_cidr_block
  security_group_id = join("", aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "ssh_ingress" {
  count             = length(var.ssh_allowed_ip) > 0 && length(var.sg_ids) < 1 ? length(compact(var.ssh_allowed_ports)) : 0
  description       = var.ssh_sg_ingress_description
  type              = "ingress"
  from_port         = element(var.ssh_allowed_ports, count.index)
  to_port           = element(var.ssh_allowed_ports, count.index)
  protocol          = var.ssh_protocol
  cidr_blocks       = var.ssh_allowed_ip
  security_group_id = join("", aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "ingress" {
  count = length(var.allowed_ip) > 0 && length(var.sg_ids) < 1 ? length(compact(var.allowed_ports)) : 0

  description       = var.sg_ingress_description
  type              = "ingress"
  from_port         = element(var.allowed_ports, count.index)
  to_port           = element(var.allowed_ports, count.index)
  protocol          = var.protocol
  cidr_blocks       = var.allowed_ip
  security_group_id = join("", aws_security_group.default[*].id)
}