module "vpc" {
  source                                  = "../../modules/vpc"
  name_prefix                             = "qburst"
  ipv4_primary_cidr_block                 = "10.0.0.0/16"
  public_subnets_cidr                     = ["10.0.64.0/19", "10.0.96.0/19"]
  private_subnets_cidr                    = ["10.0.0.0/19", "10.0.32.0/19"]
  availability_zones                      = ["us-east-1a", "us-east-1b"]
  ipv4_additional_cidr_block_associations = []
}

module "eks" {
  source = "../../modules/eks"

  vpc_cidr_block             = "10.0.0.0/16"
  private_subnet_cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnet_cidr_blocks  = ["10.0.64.0/19", "10.0.96.0/19"]
  availability_zones         = ["us-east-1a", "us-east-1b"]
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = module.vpc.private_subnet_ids
  public_subnet_ids          = module.vpc.public_subnet_ids

  eks_cluster_name    = "my-eks-cluster"
  eks_cluster_version = "1.24"

}

