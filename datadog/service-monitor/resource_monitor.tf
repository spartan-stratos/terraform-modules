resource "datadog_monitor" "cpu_monitor" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_cpu_monitor == true
  }

  name     = "[P${lookup(local.cpu.priority_levels, var.environment)}] [High CPU Utilization] [${title(each.key)}]: ${upper(var.environment)} - Service ${each.key} CPU usage is too high."
  type     = "query alert"
  message  = lookup(local.cpu.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "avg(${local.cpu.timeframe}):(avg:kubernetes.cpu.usage.total{kube_namespace:${each.key}, container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}, kube_cluster_name:${var.cluster_name}} / avg:kubernetes.cpu.limits{kube_namespace:${each.key}, container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}, kube_cluster_name:${var.cluster_name}}) / 10e6 > ${local.cpu.critical}"
  priority = lookup(local.cpu.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.cpu.critical
    critical_recovery = local.cpu.critical_recovery
  }

  renotify_interval = local.cpu.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "cpu_monitor_o1" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_cpu_monitor == true
  }

  name     = "[P${lookup(local.cpu_o1.priority_levels, var.environment)}] [High CPU Utilization] [${title(each.key)}]: ${upper(var.environment)} - Service ${each.key} CPU usage is high."
  type     = "query alert"
  message  = lookup(local.cpu_o1.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "avg(${local.cpu_o1.timeframe}):(avg:kubernetes.cpu.usage.total{kube_namespace:${each.key}, container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}, kube_cluster_name:${var.cluster_name}} / avg:kubernetes.cpu.limits{kube_namespace:${each.key}, container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}, kube_cluster_name:${var.cluster_name}}) / 10e6 > ${local.cpu_o1.critical}"
  priority = lookup(local.cpu_o1.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.cpu_o1.critical
    critical_recovery = local.cpu_o1.critical_recovery
  }

  renotify_interval = local.cpu_o1.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "memory_monitor" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_memory_monitor == true
  }

  name     = "[P${lookup(local.memory.priority_levels, var.environment)}] [High Memory Utilization] [${title(each.key)}]: ${upper(var.environment)} - Service ${each.key} Memory usage is too high."
  type     = "query alert"
  message  = lookup(local.memory.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "avg(${local.memory.timeframe}):(avg:kubernetes.memory.usage{kube_namespace:${each.key}, container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}, kube_cluster_name:${var.cluster_name}} / avg:kubernetes.memory.limits{kube_namespace:${each.key}, container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}, kube_cluster_name:${var.cluster_name}}) * 100 > ${local.memory.critical}"
  priority = lookup(local.memory.priority_levels, var.environment)

  monitor_thresholds {
    critical          = local.memory.critical
    critical_recovery = local.memory.critical_recovery
  }

  renotify_interval = local.memory.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "memory_monitor_o1" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_memory_monitor == true
  }

  name     = "[P${lookup(local.memory_o1.priority_levels, var.environment)}] [High Memory Utilization] [${title(each.key)}]: ${upper(var.environment)} - Service ${each.key} Memory usage is high."
  type     = "query alert"
  message  = lookup(local.memory_o1.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "avg(${local.memory_o1.timeframe}):(avg:kubernetes.memory.usage{kube_namespace:${each.key}, container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}, kube_cluster_name:${var.cluster_name}} / avg:kubernetes.memory.limits{kube_namespace:${each.key}, container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}, kube_cluster_name:${var.cluster_name}}) * 100 > ${local.memory_o1.critical}"
  priority = lookup(local.memory_o1.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.memory_o1.critical
    critical_recovery = local.memory_o1.critical_recovery
  }

  renotify_interval = local.memory_o1.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}
