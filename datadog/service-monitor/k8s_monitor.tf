module "k8s" {
  source = "../monitors"

  notification_slack_channel_prefix = var.notification_slack_channel_prefix
  tag_slack_channel                 = var.tag_slack_channel
  environment                       = var.environment
  service                           = "k8s"

  monitors = {
    for monitor, config in local.default_k8s_monitors :
    monitor => merge(config, try(var.override_default_monitors[monitor], {})) if contains(var.enabled_modules, "k8s")
  }
}

locals {
  default_k8s_monitors = merge(
    local.restart_monitors,
    {
      crash_loop_back_off         = local.crash_loop_back_off,
      image_pull_back_off_monitor = local.image_pull_back_off,
      failed                      = local.failed
    }
  )

  restart_monitors = {
    for service_name, monitor in var.service_names :
    "restart_${service_name}" => {
      priority_level = 2
      title_tags     = "[Service Restarts]"
      title          = "Service ${service_name} restarted"

      query_template = "avg($${timeframe}):sum:kubernetes.containers.restarts{kube_cluster_name:${var.cluster_name}, kube_service:${service_name},kube_container_name:kube_container_name:${monitor.overwrite_container_name != null ? monitor.overwrite_container_name : service_name}} by {pod_name} >= $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
      }

      threshold_critical          = 1
      threshold_critical_recovery = 0
      renotify_interval           = 60
    } if monitor.enabled_pods_monitor == true
  }

  crash_loop_back_off = {
    priority_level = 2
    title_tags     = "[CrashLoopBackOff Pod]"
    title          = "Pod {{pod_name.name}} is CrashloopBackOff on namespace {{kube_namespace.name}}"

    query_template = "max($${timeframe}):default_zero(max:kubernetes_state.container.status_report.count.waiting{kube_cluster_name:${var.cluster_name}, reason:crashloopbackoff} by {kube_cluster_name, kube_namespace, pod_name}) >= $${threshold_critical}"
    query_args = {
      timeframe = "last_5m"
    }

    threshold_critical          = 1
    threshold_critical_recovery = 0
    renotify_interval           = 60
  }

  image_pull_back_off = {
    priority_level = 2
    title_tags     = "[ImagePullBackOff Pod]"
    title          = "Pod {{pod_name.name}} is ImagePullBackOff on namespace {{kube_namespace.name}}"

    query_template = "max($${timeframe}):default_zero(max:kubernetes_state.container.status_report.count.waiting{kube_cluster_name:${var.cluster_name}, reason:imagepullbackoff} by {kube_cluster_name, kube_namespace, pod_name}) >= $${threshold_critical}"
    query_args = {
      timeframe = "last_5m"
    }

    threshold_critical          = 1
    threshold_critical_recovery = 0
    renotify_interval           = 60
  }

  failed = {
    priority_level = 2
    title_tags     = "[Failed Pod]"
    title          = "Pod {{pod_name.name}} is Failed on namespace {{kube_namespace.name}}"

    query_template = "max($${timeframe}):default_zero(max:kubernetes_state.container.status_report.count.waiting{kube_cluster_name:${var.cluster_name}, reason:failed} by {kube_cluster_name, kube_namespace, pod_name}) >= $${threshold_critical}"
    query_args = {
      timeframe = "last_5m"
    }

    threshold_critical          = 1
    threshold_critical_recovery = 0
    renotify_interval           = 60
  }
}
