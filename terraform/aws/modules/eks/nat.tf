resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "Qburst-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_us_east_1a.id

  tags = {
    Name = var.nat_gateway_name
  }

  depends_on = [aws_internet_gateway.igw]
}
