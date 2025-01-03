variable "environment" {
  description = "Environment where the resources will be created."
  type        = string
}

variable "service_names" {
  description = "A map of service names and options whether to create corresponding monitors, including CPU, memory, pods, and service monitoring. Additionally, it can specify whether to overwrite the container name to match the query."
  type = map(object({
    enabled_cpu_monitor      = optional(bool)
    enabled_memory_monitor   = optional(bool)
    enabled_pods_monitor     = optional(bool)
    enabled_service_monitor  = optional(bool)
    overwrite_container_name = optional(string)
  }))
  default = null
}

variable "create_http_check_monitors" {
  description = "Whether HTTP check monitors should be created. Set to 'true' to create the monitors, 'false' to disable."
  type        = bool
  default     = false
}

variable "create_k8s_monitors" {
  description = "Whether Kubernetes-specific monitors should be created. Set to 'true' to create the monitors, 'false' to disable."
  type        = bool
  default     = false
}

variable "create_resource_monitors" {
  description = "Whether resource monitors (e.g., CPU, memory, etc.) should be created. Set to 'true' to create the monitors, 'false' to disable."
  type        = bool
  default     = false
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
  description = <<EOF
    A map of overridden monitors. The key is the monitor name and the value is a map of monitor attributes. The following attributes are required:
    - enabled: Whether the monitor is enabled.
    - priority_level: The priority level of the monitor.
    - title_tags: The tags to include in the title of the monitor.
    - title: The title of the monitor.
    - type: The type of the monitor.
    - query_template: The template for the monitor query.
    - query_args: The arguments for the monitor query.
    - threshold_critical: The critical threshold for the monitor.
    - threshold_critical_recovery: The critical recovery threshold for the monitor.
    - threshold_ok: The recovery threshold for the monitor. Only supported in monitor type `service check`.
    - renotify_interval: The renotify interval for the monitor.

    The following attributes are optional:
    - renotify_occurrences: The renotify occurrences for the monitor.
    - require_full_window: Whether the monitor requires a full window.
    - enabled_include_tags: Whether to include tags in the monitor.
    - additional_tags: Additional tags to include in the monitor.
    - notification_preset_name: The notification preset name for the monitor.
  EOF
  type = map(object({
    enabled                     = optional(bool)
    priority_level              = optional(number)
    title_tags                  = optional(string)
    title                       = optional(string)
    type                        = optional(string)
    query_template              = optional(string)
    query_args                  = optional(map(string))
    threshold_critical          = optional(number)
    threshold_critical_recovery = optional(number)
    threshold_ok                = optional(number)
    renotify_interval           = optional(number)
    renotify_occurrences        = optional(number)
    require_full_window         = optional(bool)
    enabled_include_tags        = optional(bool)
    additional_tags             = optional(list(string))
    notification_preset_name    = optional(string)
  }))
  default = {}
}

variable "tag_slack_channel" {
  description = "Whether to tag the Slack channel in the message"
  type        = bool
  default     = true
}
