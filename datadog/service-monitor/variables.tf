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

variable "dd_users" {
  type    = list(string)
  default = []
}

variable "cluster_name" {
  description = "The Kubernetes cluster name"
  type        = string
}

variable "notification_slack_channel_prefix" {
  description = "The prefix for Slack channels that will receive notifcations and alerts"
  type        = string
}

variable "anomaly_throughput" {
  type = object({
    algorithms         = string
    deviations         = number
    alert_window       = string
    rollup_interval    = number
    count_default_zero = bool
  })
}
