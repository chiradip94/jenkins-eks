output "eks_cluster_name" {
  description = "The name of the cluster"
  value = aws_eks_cluster.this.name
}

output "jenkins_namespace" {
  description = "The namespace where jenkins is deployed"
  value       = var.jenkins_namespace
}

output "jenkins_access_url" {
  description = "The name of the cluster"
  value = "http://${data.kubernetes_service.jenkins.status.0.load_balancer.0.ingress.0.hostname}:${data.kubernetes_service.jenkins.spec.0.port.0.port}"
}