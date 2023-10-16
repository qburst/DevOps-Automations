module "vpc" {
  source                                  = "../../modules/vpc"
  name_prefix                             = "qburst"
  ipv4_primary_cidr_block                 = var.vpc_cidr_block
  public_subnets_cidr                     = var.public_subnet_cidr_blocks
  private_subnets_cidr                    = var.private_subnet_cidr_blocks
  availability_zones                      = var.availability_zones
  ipv4_additional_cidr_block_associations = var.ipv4_additional_cidr
  nat_gw_enabled = true
}
