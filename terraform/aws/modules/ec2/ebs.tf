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
  volume_id   = aws_ebs_volume.ebs_volume[count.index].id
  instance_id = aws_instance.instance.id
}