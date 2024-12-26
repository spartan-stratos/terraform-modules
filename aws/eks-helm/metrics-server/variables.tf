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

variable "set_configs" {
  description = "To specify the list of set configs"
  type = list(object({
    name = string,
    value = any
  }))
  default = [{
    name  = "metrics.enabled"
    value = false
  }]
}

variable "set_list_config" {
  description = "To specify the list value of a single configs"
  type = list(object({
    name = string,
    value = list(any)
  }))
  default = []
}
