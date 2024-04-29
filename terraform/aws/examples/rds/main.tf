
module "aws-vpc" {
  source                                  = "../../modules/vpc"
  name_prefix                             = "qburst"
  ipv4_primary_cidr_block                 = "10.0.0.0/16"
  ipv4_additional_cidr_block_associations = []
  public_subnets_cidr                     = ["10.0.64.0/19", "10.0.96.0/19"]
  private_subnets_cidr                    = ["10.0.0.0/19", "10.0.32.0/19"]
  availability_zones                      = ["ap-south-1a", "ap-south-1b"]
}

module "aws-rds" {
  source              = "../../modules/rds"
  vpc_id              = module.aws-vpc.vpc_id
  subnet_ids          = module.aws-vpc.private_subnet_ids
  engine              = "mysql"
  engine_version      = "8.0.33"
  instance_class      = "db.t3.micro"
  database_user       = "QB"
  database_port       = 3306
  allocated_storage   = 5
  db-identifier       = "mysql"
  
}

