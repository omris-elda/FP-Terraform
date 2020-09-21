provider "aws" {
  version = "~> 2.0"
  profile = "default"
  region  = "eu-west-1"
}

module "aws_vpc" {
  source = "./VPC"
}

module "aws_security_group" {
  source = "./SecurityGroup"
  vpc_id = module.aws_vpc.vpc_id
}

module "cluster" {
  source                 = "./KubernetesCluster"
  public_subnet_id       = module.aws_vpc.public_subnet_id
  vpc_security_group_ids = module.aws_security_group.SecGrp_ID
}

module "nodes" {
  source = "./KubernetesNodes"
  subnet_ids = module.aws_vpc.public_subnet_id
  cluster_name = module.aws_eks_cluster.cluster-name
}