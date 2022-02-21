module "nodegroup_role" {
  source = "./modules/iam"

  service_name        = "ec2"
  role_name           = local.nodegroup_role_name
  tags                = var.tags 
  cluster_iam_policy  = local.nodegroup_iam_policy
}

module "node_group" {
  source = "./modules/node_group"

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-ng1"
  role_arn        = module.nodegroup_role.arn
  subnet_ids      = var.subnet_ids
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = " aws eks update-kubeconfig --name ${aws_eks_cluster.this.name}"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [
    module.node_group
  ]
}

resource "null_resource" "install_jenkins" {
  provisioner "local-exec" {
    command = "helm install jenkins-server ../helm -n tools --create-namespace"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [
    null_resource.update_kubeconfig
  ]
}