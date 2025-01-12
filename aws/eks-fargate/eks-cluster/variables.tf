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

variable "create_fargate_profile" {
  type        = bool
  description = "Specify whether creaing the Fargate profile for running pods."
  default     = false
}

variable "fargate_profiles" {
  type        = any
  description = "Configuration block(s) for selecting Kubernetes Pods to execute with this Fargate Profile"
  default     = {}
}

variable "fargate_timeouts" {
  type = object({
    create = string
    delete = string
  })
  description = "Default timeout attributes."
  default = {
    create = "20m"
    delete = "20m"
  }
}

variable "filesystem_encrypted" {
  description = "Enable encryption for EFS"
  default     = true
  type        = bool
}

variable "filesystem_performance_mode" {
  description = "The file system performance mode."
  type        = string
  default     = "generalPurpose"
}

variable "filesystem_throughput_mode" {
  description = "Throughput mode for the file system."
  type        = string
  default     = "bursting"
}

variable "efs_storage_class_name" {
  type    = string
  default = "efs"
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

variable "efs_lifecycle_policy" {
  description = "Lifecycle Policy for the EFS Filesystem"
  type = list(object({
    transition_to_ia                    = string
    transition_to_primary_storage_class = string
  }))
  default = []
}

variable "efs_filesystem_name" {
  description = "To specify the name of efs filesystem in case overwrite the default one"
  type        = string
  default     = null
}

variable "datadog_agent_cluster_role_name" {
  type        = string
  description = "Name of the ClusterRole to create in order to configure Datadog Agents"
  default     = "datadog-agent"
}

variable "enabled_cloudwatch_logging" {
  type        = bool
  default     = false
  description = "Enable logging for Kubernetes Pods through built in EKS Fargate Firelens"
}

variable "enabled_efs" {
  type        = bool
  description = "Enable EFS creation for persistence volumes"
  default     = false
}

variable "custom_namespaces" {
  type        = list(string)
  description = "Custom namespaces to be created during initialization"
  default     = []
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "The Kubernetes version to use for the EKS cluster"
  default     = "1.31"
}

variable "k8s_core_dns_compute_type" {
  type        = string
  description = "The compute type for the core DNS"
  default     = "ec2"
}
