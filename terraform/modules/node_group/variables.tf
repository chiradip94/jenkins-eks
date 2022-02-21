variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "tools-cluster"
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
  default     = "eks-managed-ng"
}

variable "role_arn" {
  description = "The Role's ARN to attach to the node group"
  type        = string
  default     = "eks-managed-ng"
}

variable "subnet_ids" {
  description = "The list of subnets for the node group"
  type        = list(string)
  default     = []
}

variable "desired_size" {
  description = "The desired size of node group"
  type        = string
  default     = "2"
}

variable "max_size" {
  description = "The maximum size of node group"
  type        = string
  default     = "2"
}

variable "min_size" {
  description = "The minimum size of node group"
  type        = string
  default     = "2"
}

variable "max_unavailable" {
  description = "Desired max number of unavailable worker nodes during node group update"
  type        = string
  default     = "2"
}