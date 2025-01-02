variable "environment" {
  description = "Environment where the resources will be created."
  type        = string
}

variable "service_names" {
  type = map(object({
    enabled_cpu_monitor      = optional(bool)
    enabled_memory_monitor   = optional(bool)
    enabled_pods_monitor     = optional(bool)
    enabled_service_monitor  = optional(bool)
    overwrite_container_name = optional(string)
  }))
  default = {}
}

variable "cluster_name" {
  description = "The Kubernetes cluster name"
  type        = string
}

variable "notification_slack_channel_prefix" {
  description = "The prefix for Slack channels that will receive notifcations and alerts"
  type        = string
}

variable "override_default_monitors" {
  type        = map(map(any))
  default     = {}
  description = "Override default monitors with custom configuration"
}

variable "enabled_modules" {
  description = "List of modules to enable, must be one of http_check, k8s, resource, service."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for module_name in var.enabled_modules : contains(["http_check", "k8s", "resource", "service"], module_name)])
    error_message = "Invalid module name, must be one of http_check, k8s, resource, service."
  }
}

variable "tag_slack_channel" {
  description = "Whether to tag the Slack channel in the message"
  type        = bool
  default     = true
}
