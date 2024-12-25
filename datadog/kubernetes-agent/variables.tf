variable "namespace" {
  description = "The Namespace of the services."
  type        = string
  default     = "datadog"
}

variable "environment" {
  description = "Environment where the resources will be created."
  type        = string
}

variable "helm_release_name" {
  description = "The Helm release of the services."
  type        = string
  default     = "datadog"
}

variable "datadog_api_key" {
  description = "The datadog api key"
  type        = string
}

variable "datadog_app_key" {
  description = "The datadog app key"
  type        = string
}

variable "datadog_site" {
  description = "The datadog site"
  type        = string
}

variable "http_check_urls" {
  description = "The list of urls for http check"
  type        = list(string)
  default     = []
}

variable "timeout" {
  description = "Default timeout of datadog"
  default     = 1200
}

variable "cluster_name" {
  type        = string
  description = "The EKS cluster name"
}

variable "chart_version" {
  type        = string
  default     = "3.85.0"
  description = "The version of the datadog chart"
}

variable "datadog_envs" {
  description = "Environment variables for datadog agents"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
