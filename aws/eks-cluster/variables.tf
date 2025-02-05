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

variable "create_fargate_profile" {
  type        = bool
  description = "Specify whether creating the Fargate profile for running pods."
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

variable "node_groups" {
  description = "Key-value mapping of Kubernetes node groups attributes"
  default     = {}
  type        = any
}

variable "administrator_role_arn" {
  type        = string
  default     = null
  description = "AWS Administrator role arn for mapping with K8s RBAC"
}

variable "default_service_account" {
  type        = string
  description = "Default service account name for binding with Datadog"
  default     = "default"
}

variable "enabled_datadog_agent" {
  type        = bool
  description = "Enable datadog integration RBAC creation"
  default     = false
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

variable "addons_vpc_cni_version" {
  type        = string
  description = "The version of the VPC CNI addon, latest by default"
  default     = null
}

variable "addons_kube_proxy_version" {
  type        = string
  description = "The version of the kube-proxy addon, latest by default"
  default     = null
}

variable "addons_coredns_version" {
  type        = string
  description = "The version of the CoreDNS addon, latest by default"
  default     = null
}

variable "enabled_endpoint_private_access" {
  type        = bool
  default     = true
  description = "Enable private access for the Kubernetes API server endpoint."
}

variable "enabled_endpoint_public_access" {
  type        = bool
  default     = true
  description = "Enable public access for the Kubernetes API server endpoint."
}

variable "public_access_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks allowed for public access to the Kubernetes API server endpoint."
}

variable "enabled_config_map" {
  description = "Enable CONFIG_MAP authentication"
  type        = bool
  default     = true
}

variable "enabled_api" {
  description = "Enable API authentication"
  type        = bool
  default     = false
}

variable "enabled_api_and_config_map" {
  description = "Enable API_AND_CONFIG_MAP authentication"
  type        = bool
  default     = false
}

variable "access_entries" {
  description = "List of access entries for EKS access entries and policies"
  type = map(object({
    principal_arn     = string
    kubernetes_groups = optional(list(string))
    type              = optional(string)
    policy_arn        = optional(string)
    namespaces        = optional(list(string))
    access_type       = optional(string, "CLUSTER")
  }))
  default = {}
}
