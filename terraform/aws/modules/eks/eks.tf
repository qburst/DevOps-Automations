resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo_amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "demo" {
  name     = var.eks_cluster_name
  version  = var.eks_cluster_version
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = concat(
      module.vpc.private_subnet_ids,
      module.vpc.public_subnet_ids
    )
  }


  depends_on = [aws_iam_role_policy_attachment.demo_amazon_eks_cluster_policy]
}