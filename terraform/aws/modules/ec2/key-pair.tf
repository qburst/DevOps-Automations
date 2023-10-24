resource "tls_private_key" "default" {
  count     = var.ssh_key.public_key == "" && var.ssh_key.key_name == "" ? 1 : 0
  algorithm = var.ssh_key.algorithm
  rsa_bits  = var.ssh_key.rsa_bits
}

resource "aws_key_pair" "default" {
  count      = var.ssh_key.key_name == "" ? 1 : 0
  key_name   = var.instance_name
  public_key = var.ssh_key.public_key == "" ? join("", tls_private_key.default[*].public_key_openssh) : var.ssh_key.public_key
  tags = {
    Name = "${var.instance_name}-key"
  }
}