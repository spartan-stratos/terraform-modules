variable "namespace" {
  description = "The Namespace of the services."
  type        = string
  default     = "spartan"
}
variable "helm_release_name" {
  description = "The Helm release of the services."
  type        = string
  default     = "opa"
}

variable "helm_chart_version" {
  default     = "0.1.13"
  type        = string
  description = "The chart version of OPA engine"
}
