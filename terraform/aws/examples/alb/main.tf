data "aws_vpc" "mng_intranet" {
  tags = {
    Name = "mng-vpc-intranet01"
  }
}

data "aws_subnet" "trusted_a" {
  vpc_id = data.aws_vpc.mng_intranet.id

  tags = {
    Name = "mng-vpc-subnet-trusteda01"
  }
}

data "aws_subnet" "trusted_c" {
  vpc_id = data.aws_vpc.mng_intranet.id

  tags = {
    Name = "mng-vpc-subnet-trustedc01"
  }
}

data "aws_security_group" "alb" {
  filter {
    name   = "tag:Name"
    values = ["mng-vpc-sg-default01"]
  }

  vpc_id = data.aws_vpc.mng_intranet.id
}

data "aws_acm_certificate" "this" {
  domain      = "cloudmigration-poc.internal"
  most_recent = true
  statuses    = ["ISSUED"]
}

module "alb" {
  source = "../../modules/alb"

  name   = "mng-alb-cloudmigration-poc01"
  vpc_id = data.aws_vpc.mng_intranet.id

  subnet_ids = [
    data.aws_subnet.trusted_a.id,
    data.aws_subnet.trusted_c.id,
  ]

  security_group_ids = [
    data.aws_security_group.alb.id,
  ]

  idle_timeout = 60

  target_group_name = "cloudmigration-poc-tg01"
  target_group_port = 8080
  target_type       = "ip"

  health_check_path                = "/health"
  health_check_healthy_threshold   = 3
  health_check_unhealthy_threshold = 3
  health_check_timeout             = 5
  health_check_interval            = 30
  health_check_matcher             = "200"

  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = data.aws_acm_certificate.this.arn

  tags = {
    ManagedBy   = "terraform"
    Project     = "CloudMigration-PoC"
    Environment = "Type-Int"
  }
}

