variable "datadog_agent_cluster_role_name" {
  type    = string
  default = "datadog-agent"
}

variable "fargate_profiles" {
  type        = any
  description = "Configuration block(s) for selecting Kubernetes Pods to execute with this Fargate Profile"
  default     = {}
}

variable "default_service_account" {
  type        = string
  description = "Default service account name for binding with Datadog"
  default     = "default"
}

variable "custom_namespaces" {
  type        = list(string)
  description = "Custom namespaces to be created during initialization"
  default     = []
}
