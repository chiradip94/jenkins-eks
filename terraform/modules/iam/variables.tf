variable "service_name" {
  description = "Name of the Service to trust"
  type        = string
  default     = null
}

variable "role_name" {
  description = "Name of the role"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for the role"
  type        = map(string)
  default     = {}
}

variable "cluster_iam_policy" {
  description = "Name of the EKS cluster"
  type        = set(string)
  default     = []
}