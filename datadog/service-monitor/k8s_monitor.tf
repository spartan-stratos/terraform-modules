resource "datadog_monitor" "restart_status_monitor_o1" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_pods_monitor == true
  }

  name     = "[P${lookup(local.restart_time_o1.priority_levels, var.environment)}] [Service restarts] [${title(each.key)}]: ${upper(var.environment)} - Service ${each.key} Restarted."
  type     = "query alert"
  message  = lookup(local.restart_time_o1.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "avg(${local.restart_time_o1.timeframe}):sum:kubernetes.containers.restarts{kube_cluster_name:${var.cluster_name}, kube_namespace:${each.key},kube_container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}} by {pod_name} >= ${local.restart_time_o1.critical}"
  priority = lookup(local.restart_time_o1.priority_levels, var.environment)
  monitor_thresholds {
    critical = local.restart_time_o1.critical
  }

  renotify_interval = local.restart_time_o1.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}", "cluster-name:${var.cluster_name}", "integration:kubernetes"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "restart_status_monitor" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_pods_monitor == true
  }

  name     = "[P${lookup(local.restart_time.priority_levels, var.environment)}] [Service restarts] [${title(each.key)}]: ${upper(var.environment)} - Service ${each.key} Restarted too many times (>=2)."
  type     = "query alert"
  message  = lookup(local.restart_time.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "avg(${local.restart_time.timeframe}):sum:kubernetes.containers.restarts{kube_cluster_name:${var.cluster_name}, kube_namespace:${each.key},kube_container_name:${each.value.overwrite_container_name != null ? each.value.overwrite_container_name : each.key}} by {pod_name} >= ${local.restart_time.critical}"
  priority = lookup(local.restart_time.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.restart_time.critical
    critical_recovery = local.restart_time.critical_recovery
  }

  renotify_interval = local.restart_time.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}", "cluster-name:${var.cluster_name}", "integration:kubernetes"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "pods_crash_loop_back_off_monitor_o1" {
  name     = "[P${lookup(local.crash_loop_back_off_time_o1.priority_levels, var.environment)}] [CrashLoopBackOff Pod]: ${upper(var.environment)} - Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}."
  type     = "query alert"
  message  = lookup(local.crash_loop_back_off_time_o1.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "max(${local.crash_loop_back_off_time_o1.timeframe}):default_zero(max:kubernetes_state.container.status_report.count.waiting{kube_cluster_name:${var.cluster_name}, reason:crashloopbackoff} by {kube_cluster_name, kube_namespace, pod_name}) >= ${local.crash_loop_back_off_time_o1.critical}"
  priority = lookup(local.crash_loop_back_off_time_o1.priority_levels, var.environment)
  monitor_thresholds {
    critical = local.crash_loop_back_off_time_o1.critical
  }

  renotify_interval = local.crash_loop_back_off_time_o1.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "cluster-name:${var.cluster_name}", "integration:kubernetes"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "pods_crash_loop_back_off_monitor" {
  name     = "[P${lookup(local.crash_loop_back_off_time.priority_levels, var.environment)}] [CrashLoopBackOff Pod]: ${upper(var.environment)} - Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}} too many times (>=2)"
  type     = "query alert"
  message  = lookup(local.crash_loop_back_off_time.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "max(${local.crash_loop_back_off_time.timeframe}):default_zero(max:kubernetes_state.container.status_report.count.waiting{kube_cluster_name:${var.cluster_name}, reason:crashloopbackoff} by {kube_cluster_name, kube_namespace, pod_name}) >= ${local.crash_loop_back_off_time.critical}"
  priority = lookup(local.crash_loop_back_off_time.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.crash_loop_back_off_time.critical
    critical_recovery = local.crash_loop_back_off_time.critical_recovery
  }

  renotify_interval = local.crash_loop_back_off_time.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "cluster-name:${var.cluster_name}", "integration:kubernetes"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "pods_image_pull_back_off_monitor_o1" {
  name     = "[P${lookup(local.image_pull_back_off_time_o1.priority_levels, var.environment)}] [ImagePullBackOff Pod]: ${upper(var.environment)} - Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"
  type     = "query alert"
  message  = lookup(local.image_pull_back_off_time_o1.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "max(${local.image_pull_back_off_time_o1.timeframe}):default_zero(max:kubernetes_state.container.status_report.count.waiting{kube_cluster_name:${var.cluster_name}, reason:imagepullbackoff} by {kube_cluster_name, kube_namespace, pod_name}) >= ${local.image_pull_back_off_time_o1.critical}"
  priority = lookup(local.image_pull_back_off_time_o1.priority_levels, var.environment)
  monitor_thresholds {
    critical = local.image_pull_back_off_time_o1.critical
  }

  renotify_interval = local.image_pull_back_off_time_o1.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "cluster-name:${var.cluster_name}", "integration:kubernetes"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "pods_image_pull_back_off_monitor" {
  name     = "[P${lookup(local.image_pull_back_off_time.priority_levels, var.environment)}] [ImagePullBackOff Pod]: ${upper(var.environment)} - Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}} too many times (>=2)"
  type     = "query alert"
  message  = lookup(local.image_pull_back_off_time.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "max(${local.image_pull_back_off_time.timeframe}):default_zero(max:kubernetes_state.container.status_report.count.waiting{kube_cluster_name:${var.cluster_name}, reason:imagepullbackoff} by {kube_cluster_name, kube_namespace, pod_name}) >= ${local.image_pull_back_off_time.critical}"
  priority = lookup(local.image_pull_back_off_time.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.image_pull_back_off_time.critical
    critical_recovery = local.image_pull_back_off_time.critical_recovery
  }

  renotify_interval = local.image_pull_back_off_time.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "cluster-name:${var.cluster_name}", "integration:kubernetes"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "failed_pods_monitor_o1" {
  name     = "[P${lookup(local.failed_pods_time_o1.priority_levels, var.environment)}] [Failed Pod]: ${upper(var.environment)} - Kubernetes Failed Pods in Namespaces"
  type     = "query alert"
  message  = lookup(local.failed_pods_time_o1.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "avg(${local.failed_pods_time_o1.timeframe}):default_zero(sum:kubernetes_state.pod.status_phase{kube_cluster_name:${var.cluster_name}, pod_phase:failed} by {kube_cluster_name, kube_namespace}) >= ${local.failed_pods_time_o1.critical}"
  priority = lookup(local.failed_pods_time_o1.priority_levels, var.environment)
  monitor_thresholds {
    critical = local.failed_pods_time_o1.critical
  }

  renotify_interval = local.failed_pods_time_o1.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "cluster-name:${var.cluster_name}", "integration:kubernetes"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "failed_pods_monitor" {
  name     = "[P${lookup(local.failed_pods_time.priority_levels, var.environment)}] [Failed Pod]: ${upper(var.environment)} - Kubernetes Failed Pods in Namespaces too many times (>=2)"
  type     = "query alert"
  message  = lookup(local.failed_pods_time.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "avg(${local.failed_pods_time.timeframe}):default_zero(sum:kubernetes_state.pod.status_phase{kube_cluster_name:${var.cluster_name}, pod_phase:failed} by {kube_cluster_name, kube_namespace}) >= ${local.failed_pods_time.critical}"
  priority = lookup(local.failed_pods_time.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.failed_pods_time.critical
    critical_recovery = local.failed_pods_time.critical_recovery
  }

  renotify_interval = local.failed_pods_time.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "cluster-name:${var.cluster_name}", "integration:kubernetes"]

  notification_preset_name = local.notification_preset_name
}
