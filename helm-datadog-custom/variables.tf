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

variable "http_check_urls" {
  description = "The list of urls for http check"
  type        = list(string)
  default     = []
}

variable "timeout" {
  description = "Default timeout of datadog"
  default     = 1200
}

variable "deployment_cpu" {
  description = "The Datadog deployment cpu"
  type        = string
  default     = "250m"
}

variable "deployment_memory" {
  description = "The Datadog deployment memory"
  type        = string
  default     = "512Mi"
}

variable "deployment_replicas" {
  description = "The Datadog deployment replicas"
  type        = number
  default     = 1
}

variable "remote_config_enabled" {
  description = "Enable Remote Config feature (see https://docs.datadoghq.com/agent/remote_config/)"
  type        = bool
  default     = false
}

variable "rolling_agent_max_unavailable" {
  description = "Maximum number or percentage of Datadog Agent pods that can be unavailable during a rolling update."
  type        = string
  default     = "30%"
}

variable "datadog_image_tag" {
  description = "The Datadog Agent and Cluster Agent image tag."
  type        = string
}

variable "container_exclude" {
  description = "Space-separated list of container filters that Datadog will NOT collect logs/metrics from. Matched containers are silenced. Default excludes all namespaces; use container_include to allow specific ones back in."
  type        = string
  default     = "kube_namespace:.*"
}

variable "container_include" {
  description = "Space-separated list of container filters that Datadog WILL collect logs/metrics from. Takes precedence over container_exclude, so only namespaces/containers matching these patterns are monitored."
  type        = string
  default     = "kube_namespace:^service-.* kube_namespace:^datadog$ name:^controller$"
}

variable "cloud_provider" {
  description = "Cloud provider platform for Datadog Agent deployment. One of: gke-autopilot, gke-cos, eks, aks."
  type        = string

  validation {
    condition     = contains(["gke-autopilot", "gke-cos", "eks", "aks"], var.cloud_provider)
    error_message = "cloud_provider must be one of: gke-autopilot, gke-cos, eks, aks."
  }
}
