# create Security Group
data "aws_vpc" "default" {
  default = true
}

resource "aws_default_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "aws-sg" {
  name        = "teraform-sg"
  description = "Allow ingress traffic via Terraform"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = lookup(ingress.value, "description", null)
      from_port   = lookup(ingress.value, "from_port", null)
      to_port     = lookup(ingress.value, "to_port", null)
      protocol    = lookup(ingress.value, "protocol", null)
      cidr_blocks = lookup(ingress.value, "cidr_blocks", null)
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = lookup(egress.value, "description", null)
      from_port   = lookup(egress.value, "from_port", null)
      to_port     = lookup(egress.value, "to_port", null)
      protocol    = lookup(egress.value, "protocol", null)
      cidr_blocks = lookup(egress.value, "cidr_blocks", null)
    }
  }

  tags = {
    Name = "teraform-sg"
  }

}