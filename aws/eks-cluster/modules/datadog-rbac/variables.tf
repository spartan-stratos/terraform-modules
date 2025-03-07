variable "datadog_agent_cluster_role_name" {
  type        = string
  description = "Name of the ClusterRole to create in order to configure Datadog Agents"
}

variable "fargate_profiles" {
  type        = any
  description = "Configuration block(s) for selecting Kubernetes Pods to execute with this Fargate Profile"
  default     = {}
}

variable "custom_service_accounts" {
  type        = map(list(string))
  description = <<EOF
Map of service account names for binding with Datadog.
Each key represents a namespace, and the value is a list of service account names.
  {
    namespace = ["service-account1", "service-account2] 
  }
EOF
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
