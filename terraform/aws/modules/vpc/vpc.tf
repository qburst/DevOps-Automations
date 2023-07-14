# VPC block
resource "aws_vpc" "default" {
  cidr_block           = var.ipv4_primary_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.dns_hostnames_enabled
  enable_dns_support   = var.dns_support_enabled

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "default" {
  for_each = toset(var.ipv4_additional_cidr_block_associations)

  cidr_block = each.value
  vpc_id     = aws_vpc.default.id
}

# Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)

  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.private_subnets_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name_prefix}-private-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)

  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-public-${count.index}"
  }
}

# Elastic IP
resource "aws_eip" "nat_gw" {
  count = length(var.public_subnets_cidr) > 0 && var.nat_gw_enabled ? 1 : 0
  vpc   = true

  tags = {
    Name = "${var.name_prefix}-nat-eip"
  }
}

# Gateway
resource "aws_internet_gateway" "default" {
  count  = length(var.public_subnets_cidr) > 0 ? 1 : 0
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

resource "aws_nat_gateway" "default" {
  count         = length(var.public_subnets_cidr) > 0 && var.nat_gw_enabled ? 1 : 0
  allocation_id = aws_eip.nat_gw[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.name_prefix}-nat-gw"
  }
}

# Route Tables
resource "aws_route_table" "public" {
  count  = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.name_prefix}-public-route-table-${count.index}"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.name_prefix}-private-route-table-${count.index}"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidr)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route" "nat_gateway" {
  count = length(var.public_subnets_cidr) > 0 && var.nat_gw_enabled ? length(var.private_subnets_cidr) : 0

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.default.*.id, count.index)
}

resource "aws_route" "internet_gateway" {
  count = length(var.public_subnets_cidr) > 0 ? length(var.public_subnets_cidr) : 0

  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(aws_internet_gateway.default.*.id, 0)
}
