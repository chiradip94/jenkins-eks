locals {
  cluster_sg_name   = "${var.cluster_name}-cluster"
  cluster_security_group_rules = {
    egress_nodes_all = {
      description                = "Cluster API to node groups"
      protocol                   = "-1"
      from_port                  = 0
      to_port                    = 65536
      type                       = "egress"
      cidr_blocks                = "0.0.0.0/0"
    }
    ingress_nodes_all = {
      description                = "Node groups to cluster API"
      protocol                   = "-1"
      from_port                  = 0
      to_port                    = 65536
      type                       = "ingress"
      self                       = true
    }
  }

  cluster_role_name     = "${var.cluster_name}-cluster"
  cluster_iam_policy = toset(["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"])

  nodegroup_role_name     = "${var.cluster_name}-nodegroup"
  nodegroup_iam_policy    = toset([
                                    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
                                    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
                                    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
                                  ])

}