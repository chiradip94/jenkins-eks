variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "tools-cluster"
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`)"
  type        = string
  default     = "1.21"
}

variable "region" {
  description = "Region for the resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC where eks is to be deployed"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnets for eks"
  type        = list(string)
  default     = []
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "jenkins_namespace" {
  description = "K8s Namespace for jenkins deployment"
  type        = string
  default     = "tools"
}

variable "chart_name" {
  description = "Name of the helm chart to be deployed"
  type        = string
  default     = "jenkins-server"
}

variable "instance_types" {
  description = "Type of worker node instances"
  type        = list(list(string))
  default     = [["t3.medium","t3.small"],["t3.medium"]]
}