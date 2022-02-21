data "aws_partition" "current" {}

module "cluster_sg" {
    source = "./modules/security_group"

    vpc_id                      = var.vpc_id
    sg_name                     = local.cluster_sg_name
    security_group_description  = "Cluster Security Group"
    security_group_rules        = local.cluster_security_group_rules
    tags                        = var.tags
}

module "cluster_role" {
  source = "./modules/iam"

  service_name        = "eks"
  role_name           = local.cluster_role_name
  tags                = var.tags 
  cluster_iam_policy  = local.cluster_iam_policy
}

resource "aws_eks_cluster" "this" {

  name                      = var.cluster_name
  role_arn                  = module.cluster_role.arn
  version                   = var.cluster_version

  vpc_config {
    security_group_ids      = [ module.cluster_sg.id ]
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }

  tags = var.tags
}