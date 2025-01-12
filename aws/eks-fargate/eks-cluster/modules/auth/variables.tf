variable "region" {
  type        = string
  description = "Region of the EKS cluster."
  default     = null
}

variable "environment" {
  type        = string
  description = "The environment name, will be used in components's name."
}

variable "name" {
  type        = string
  description = "The prefix name that will be used in cluster and components's name."
}

variable "aws_auth_users" {
  type        = list(any)
  description = "AWS users for authenticating with Kubernetes"
  default     = []
}

variable "aws_auth_accounts" {
  type        = list(any)
  description = "AWS accounts for authenticating with Kubernetes"
  default     = []
}

variable "administrator_role_arn" {
  type        = string
  default     = null
  description = "AWS Administrator role arn for mapping with K8s RBAC"
}

variable "custom_namespaces" {
  type        = list(string)
  description = "Custom namespaces to be created during initialization"
  default     = []
}

variable "fargate_profile_pod_execution_role_arn" {
  type        = string
  description = "The ARN of the IAM role that provides permissions for the EKS Fargate profile"
  default     = null
}

variable "aws_eks_cluster_arn" {
  type        = string
  description = "The ARN of the EKS cluster"
}
