variable "region" {
  type        = string
  description = "Region of the EKS cluster."
  default     = null
}

variable "cluster_version" {
  description = "The Kubernetes version for creating the cluster."
  default     = "1.31"
  type        = string
}

variable "environment" {
  type        = string
  description = "The environment name, will be used in components's name."
}

variable "name" {
  type        = string
  description = "The prefix name that will be used in cluster and components's name."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs that will be used in additional to the default ones."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC that the cluster will be created on."
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR for creating default security groups"
}
variable "public_subnet_ids" {
  type        = list(string)
  description = "The public subnet IDs in the associated VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The private subnet IDs in the associated VPC"
}

variable "k8s_core_dns_compute_type" {
  type        = string
  description = "The compute type for the core DNS"
  default     = "ec2"
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

variable "efs_backup_policy_status" {
  description = "Enable/disable backup for EFS Filesystem.  Value should be ENABLE/DISABLED.  Defaults to DISABLED"
  type        = string
  default     = "DISABLED"
  validation {
    condition     = var.efs_backup_policy_status == "ENABLED" || var.efs_backup_policy_status == "DISABLED"
    error_message = "Sorry, value must be either 'ENABLED' or 'DISABLED'."
  }
}

variable "administrator_role_arn" {
  type        = string
  default     = null
  description = "AWS Administrator role arn for mapping with K8s RBAC"
}

variable "datadog_agent_cluster_role_name" {
  type        = string
  description = "Name of the ClusterRole to create in order to configure Datadog Agents"
  default     = "datadog-agent"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  description = "Enabled logging types for EKS Control Plane"
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
