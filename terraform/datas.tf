data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
}

data "kubernetes_service" "jenkins" {
  metadata {
    name      = helm_release.jenkins-server.name
    namespace = helm_release.jenkins-server.namespace
  }
}