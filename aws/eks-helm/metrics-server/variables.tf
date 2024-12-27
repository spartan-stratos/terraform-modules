variable "namespace" {
  description = "The Namespace of the services."
  type        = string
  default     = "kube-system"
}
variable "helm_release_name" {
  description = "The Helm release of the services."
  type        = string
  default     = "metrics-server"
}

variable "helm_chart_version" {
  default     = "3.12.2"
  type        = string
  description = "The chart version of ingress controller"
}

variable "set_metrics_enabled" {
  description = "To allow unauthenticated access to /metrics if value is true"
  type = object({
    name  = string
    value = bool
  })
  default = {
    name  = "metrics.enabled"
    value = false
  }
}

variable "set_container_port" {
  description = "To specify the port number for a container"
  type = object({
    name  = string
    value = number
  })
  default = null
}

variable "set_rbac_create" {
  description = "To create EKS RBAC resources"
  type = object({
    name  = string
    value = bool
  })
  default = null
}

variable "set_list_config" {
  description = "To specify the list value of a single configs"
  type        = list(any)
  default     = []
}
