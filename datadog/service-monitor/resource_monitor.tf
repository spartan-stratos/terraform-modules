module "resource" {
  source = "../monitors"

  notification_slack_channel_prefix = var.notification_slack_channel_prefix
  tag_slack_channel                 = var.tag_slack_channel
  environment                       = var.environment
  service                           = "resource"

  monitors = {
    for monitor, config in local.default_resource_monitors :
    monitor => merge(config, try(var.override_default_monitors[monitor], {})) if contains(var.enabled_modules, "resource")
  }
}

locals {
  default_resource_monitors = merge(
    local.cpu_monitors,
    local.memory_monitors
  )

  cpu_monitors = {
    for service_name, monitor in var.service_names :
    "cpu_${service_name}" => {
      priority_level = 3
      title_tags     = "[High CPU Utilization]"
      title          = "Service ${service_name} CPU utilization is high"

      query_template = "avg($${timeframe}):(avg:kubernetes.cpu.usage.total{kube_service:${service_name}, container_name:${monitor.overwrite_container_name != null ? monitor.overwrite_container_name : service_name}, kube_cluster_name:${var.cluster_name}} / avg:kubernetes.cpu.limits{kube_service:${service_name}, container_name:${monitor.overwrite_container_name != null ? monitor.overwrite_container_name : service_name}, kube_cluster_name:${var.cluster_name}}) / 10e6 > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
      }

      threshold_critical          = 80
      threshold_critical_recovery = 70
      renotify_interval           = 60
    } if monitor.enabled_cpu_monitor == true
  }

  memory_monitors = {
    for service_name, monitor in var.service_names :
    "memory_${service_name}" => {
      priority_level = 3
      title_tags     = "[High Memory Utilization]"
      title          = "Service ${service_name} Memory utilization is high"

      query_template = "avg($${timeframe}):(avg:kubernetes.memory.usage{kube_service:${service_name}, container_name:${monitor.overwrite_container_name != null ? monitor.overwrite_container_name : service_name}, kube_cluster_name:${var.cluster_name}} / avg:kubernetes.memory.limits{kube_service:${service_name}, container_name:${monitor.overwrite_container_name != null ? monitor.overwrite_container_name : service_name}, kube_cluster_name:${var.cluster_name}}) * 100 > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
      }

      threshold_critical          = 80
      threshold_critical_recovery = 70
      renotify_interval           = 60
    } if monitor.enabled_memory_monitor == true
  }
}
