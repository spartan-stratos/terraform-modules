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
  default     = "3.11.0"
  type        = string
  description = "The chart version of ingress controller"
}
