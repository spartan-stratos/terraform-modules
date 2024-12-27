variable "custom_namespaces" {
  type        = list(string)
  description = "Custom namespaces to be created during initialization"
  default     = []
}

variable "cluster_role_name" {
  type    = string
  default = "metrics-server"
}

variable "service_account" {
  type        = string
  description = "Service account name for binding with Cluster role"
}
