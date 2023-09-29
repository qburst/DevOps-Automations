module "eks_cluster" {
  source = "../../modules/eks" # Relative path to your module directory

  # Pass input variables to the module
  vpc_cidr_block             = "10.0.0.0/16" # Example value, adjust as needed
  igw_name                   = "qburst-igw" # Example value, adjust as needed
  private_subnet_cidr_blocks = ["10.0.0.0/19", "10.0.32.0/19"] # Example values, adjust as needed
  public_subnet_cidr_blocks  = ["10.0.64.0/19", "10.0.96.0/19"] # Example values, adjust as needed
  nat_gateway_name           = "nat" # Example value, adjust as needed
  eks_cluster_name           = "my_eks_cluster" # Provide a name for your EKS cluster
}
