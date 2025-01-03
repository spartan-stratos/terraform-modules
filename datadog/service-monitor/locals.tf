locals {
  # HTTP check
  default_http_check_monitors = {
    http_check = {
      priority_level = 2
      title_tags     = "[HTTP Check]"
      title          = "URLs are not healthy"

      type           = "service check"
      query_template = "\"http.can_connect\".over(\"env:${var.environment}\").by(\"url\").last(2).count_by_status()"

      threshold_critical = 1
      ok                 = 1
      renotify_interval  = 60
    }
  }

  # K8S monitor
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

      query_template = "avg($${timeframe}):sum:kubernetes.containers.restarts{kube_cluster_name:${var.cluster_name}, kube_service:${service_name}, kube_container_name:$${kube_container_name}} by {pod_name} >= $${threshold_critical}"
      query_args = {
        timeframe           = "last_5m"
        kube_container_name = monitor.overwrite_container_name != null ? monitor.overwrite_container_name : service_name
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

  # resource monitor
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

      query_template = "avg($${timeframe}):(avg:kubernetes.cpu.usage.total{kube_service:${service_name}, kube_container_name:$${kube_container_name}, kube_cluster_name:${var.cluster_name}} / avg:kubernetes.cpu.limits{kube_service:${service_name}, kube_container_name:$${kube_container_name}, kube_cluster_name:${var.cluster_name}}) / 10e6 > $${threshold_critical}"
      query_args = {
        timeframe           = "last_5m"
        kube_container_name = monitor.overwrite_container_name != null ? monitor.overwrite_container_name : service_name
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

      query_template = "avg($${timeframe}):(avg:kubernetes.memory.usage{kube_service:${service_name}, kube_container_name:$${kube_container_name}, kube_cluster_name:${var.cluster_name}} / avg:kubernetes.memory.limits{kube_service:${service_name}, kube_container_name:$${kube_container_name}, kube_cluster_name:${var.cluster_name}}) * 100 > $${threshold_critical}"
      query_args = {
        timeframe           = "last_5m"
        kube_container_name = monitor.overwrite_container_name != null ? monitor.overwrite_container_name : service_name
      }

      threshold_critical          = 80
      threshold_critical_recovery = 70
      renotify_interval           = 60
    } if monitor.enabled_memory_monitor == true
  }

  # service monitor
  default_service_monitors = merge(
    local.p95_monitors,
    local.request_hit_monitors,
    local.error_hit_monitors
  )

  p95_monitors = {
    for service_name, monitor in var.service_names :
    "p95_${service_name}" => {
      priority_level = 3
      title_tags     = "[High P95 Latency]"
      title          = "Service ${service_name} P95 latency is high"

      query_template = "percentile($${timeframe}):p95:$${metric}{env:${var.environment},service:${service_name}} by {resource_name} > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
        metric    = local.p95_metric
      }

      threshold_critical          = 1
      threshold_critical_recovery = 0.9
      renotify_interval           = 60
    } if monitor.enabled_service_monitor == true
  }

  request_hit_monitors = {
    for service_name, monitor in var.service_names :
    "p95_${service_name}" => {
      priority_level = 3
      title_tags     = "[High Request Hits]"
      title          = "Service ${service_name} Request Hits is high"

      query_template = "sum($${timeframe}):sum:$${metric}{env:${var.environment},service:${service_name}}.as_count() > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
        metric    = local.request_hit_metric
      }

      threshold_critical          = 10000
      threshold_critical_recovery = 8000
      renotify_interval           = 60
    } if monitor.enabled_service_monitor == true
  }

  error_hit_monitors = {
    for service_name, monitor in var.service_names :
    "p95_${service_name}" => {
      priority_level = 3
      title_tags     = "[High Error Hits]"
      title          = "Service ${service_name} Error Hits is high"

      query_template = "sum($${timeframe}):sum:$${metric}{env:${var.environment},service:${service_name}}.as_count() > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
        metric    = local.error_hit_metric
      }

      threshold_critical          = 1
      threshold_critical_recovery = 0
      renotify_interval           = 60
    } if monitor.enabled_service_monitor == true
  }

  p95_metric         = "trace.fastapi.request"
  request_hit_metric = "trace.fastapi.request.hits"
  error_hit_metric   = "trace.fastapi.request.errors"
}