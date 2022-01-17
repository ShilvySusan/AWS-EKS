provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"
  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks

  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true
  tags = {
    Name = "EKSVPC"
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version = "18.2.0"
  cluster_version = "1.21"
  cluster_name    =  var.cluster_name
  vpc_id          =  module.vpc.vpc_id
  subnet_ids      =  module.vpc.private_subnets
  eks_managed_node_groups = {
    first_group = {
      desired_size = 2
      min_size = 2
      max_size = 5
      instance_types = var.instance_type
    }
}
}

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}