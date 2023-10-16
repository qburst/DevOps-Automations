module "eks" {
  source = "../../modules/eks" 

  vpc_cidr_block         = "10.0.0.0/16"
  private_subnet_cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnet_cidr_blocks  = ["10.0.64.0/19", "10.0.96.0/19"]
  availability_zones = ["us-east-1a", "us-east-1b"]

  eks_cluster_name       = "my-eks-cluster"
  eks_cluster_version    = "1.24"
  
}

