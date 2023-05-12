module "vpc" {
  source                                  = "./modules/vpc"
  name_prefix                             = "qburst"
  ipv4_primary_cidr_block                 = "172.16.0.0/16"
  ipv4_additional_cidr_block_associations = ["172.20.0.0/16","172.21.0.0/16"]
  public_subnets_cidr                     = ["172.20.0.0/20", "172.20.16.0/20"]
  private_subnets_cidr                    = ["172.21.0.0/20"]
  availability_zones                      = ["ap-south-1a", "ap-south-1b"]
}
