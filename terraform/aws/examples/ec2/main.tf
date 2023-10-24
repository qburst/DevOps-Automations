module "vpc" {
  source                                  = "../../modules/vpc"
  name_prefix                             = "qburst"
  ipv4_primary_cidr_block                 = "10.16.0.0/16"
  ipv4_additional_cidr_block_associations = ["10.20.0.0/16", "10.21.0.0/16"]
  public_subnets_cidr                     = ["10.20.0.0/20", "10.20.16.0/20"]
  private_subnets_cidr                    = ["10.21.0.0/20"]
  availability_zones                      = ["ap-south-1a", "ap-south-1b"]
}

module "ec2" {
  source            = "../../modules/ec2"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_subnet_ids
  ssh_allowed_ip    = ["0.0.0.0/0"]
  ssh_allowed_ports = [22]

  instance_count = 3
  ami            = "ami-099b3d23e336c2e83"
  instance_type  = "t2.nano"

  root_block_device = [
    {
      volume_type           = "gp2"
      volume_size           = 15
      delete_on_termination = true
    }
  ]

  ebs_volume_enabled = true
  ebs_volume_type    = "gp2"
  ebs_volume_size    = 30

  user_data = file("user-data.sh")
}
