module "nodegroup_role" {
  source = "./modules/iam"

  service_name        = "ec2"
  role_name           = local.nodegroup_role_name
  tags                = var.tags 
  cluster_iam_policy  = local.nodegroup_iam_policy
}

module "node_group" {
  source = "./modules/node_group"
  
  count           = length(var.instance_types)
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-ng-${count.index + 1}"
  role_arn        = module.nodegroup_role.arn
  subnet_ids      = var.subnet_ids
  instance_types = var.instance_types[count.index]
}

/*
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
    command = "helm install jenkins-server ../helm -n ${var.jenkins_namespace} --create-namespace"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [
    null_resource.update_kubeconfig
  ]
}
*/

resource "helm_release" "jenkins-server" {
  name              = var.chart_name
  chart             = "../helm"
  namespace         = var.jenkins_namespace
  create_namespace  = true
  depends_on = [ module.node_group ]
}