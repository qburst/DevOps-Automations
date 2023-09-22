provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

# create Security Group
data "aws_vpc" "default" {
  default = true
}

resource "aws_default_security_group" "default" {
vpc_id = data.aws_vpc.default.id
}
resource "aws_security_group" "sec_group" {
  name = "default"
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

# Create ec2 instance
resource "aws_instance" "instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.ami_key_pair_name != "" ? var.ami_key_pair_name : ""
  iam_instance_profile        = var.iam-role-name != "" ? var.iam-role-name : ""
  associate_public_ip_address = var.instance-associate-public-ip
  vpc_security_group_ids      = [aws_default_security_group.default.id, aws_security_group.aws-sg.id]
  subnet_id                   = var.subnet-id != "" ? var.subnet-id : ""
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.instance-tag-name}"
  }
}

# Attach EIP
resource "aws_eip_association" "eip-association" {
  count         = var.alloc_id == null ? 0 : 1
  instance_id   = aws_instance.instance.id
  allocation_id = var.alloc_id
}

# Create EBS volume
resource "aws_ebs_volume" "ebs_volume" {
  count             = var.ec2_additional_ebs_volume_count
  availability_zone = aws_instance.instance.availability_zone
  size              = var.ec2_additional_ebs_volume_size
  tags = {
    Name = "${var.disk-tag-name}_${count.index + 1}"
  }
}

# Attach EBS Volume
resource "aws_volume_attachment" "volume_attachment" {
  count       = var.ec2_additional_ebs_volume_count
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_volume[0].id
  instance_id = aws_instance.instance.id
}