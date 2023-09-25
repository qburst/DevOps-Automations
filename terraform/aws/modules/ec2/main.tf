# Create ec2 instance
resource "aws_instance" "instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.ami_key_pair_name != "" ? var.ami_key_pair_name : ""
  iam_instance_profile        = "${aws_iam_instance_profile.test_profile.name}"
  associate_public_ip_address = var.instance-associate-public-ip
  vpc_security_group_ids      = [aws_default_security_group.default.id, aws_security_group.aws-sg.id]
  subnet_id                   = var.subnet-id != "" ? var.subnet-id : ""
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }

  tags = {
    Name = var.instance-tag-name
  }
}

# Attach EIP
resource "aws_eip_association" "eip-association" {
  count         = var.alloc_id == null ? 0 : 1
  instance_id   = aws_instance.instance.id
  allocation_id = var.alloc_id
}