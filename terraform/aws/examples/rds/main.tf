
module "aws-vpc" {
  source                                  = "../modules/aws-vpc"
  name_prefix                             = "qburst"
  ipv4_primary_cidr_block                 = "172.16.0.0/16"
  ipv4_additional_cidr_block_associations = ["172.20.0.0/16", "172.21.0.0/16"]
  public_subnets_cidr                     = ["172.20.0.0/20", "172.20.16.0/20"]
  private_subnets_cidr                    = ["172.21.0.0/20", "172.21.16.0/20"]
  availability_zones                      = ["ap-south-1a", "ap-south-1b"]
}

module "aws-rds" {

   source                  = "../modules/aws-rds"
   vpc_id                  = module.aws-vpc.vpc_id
   subnet_ids              = module.aws-vpc.private_subnet_ids
   database_user           = "QB"
   database_port           = 3306
   allocated_storage       = 5
   engine                  = "mysql"
   engine_version          = "5.7"
   instance_class          = "db.t2.small"
   db-identifier           = "mysql"

 }

