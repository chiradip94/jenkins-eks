output "eks_cluster_name" {
  description = "The name of the cluster"
  value = aws_eks_cluster.this.name
}