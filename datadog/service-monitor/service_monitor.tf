module "service" {
  source = "../monitors"

  notification_slack_channel_prefix = var.notification_slack_channel_prefix
  tag_slack_channel                 = var.tag_slack_channel
  environment                       = var.environment
  service                           = "service"

  monitors = {
    for monitor, config in local.default_service_monitors :
    monitor => merge(config, try(var.override_default_monitors[monitor], {})) if contains(var.enabled_modules, "service")
  }
}

locals {
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

      query_template = "percentile($${timeframe}):p95:$${metric}{env:${var.environment},service:${service_name}}.as_count() > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
        metric    = local.request_hit_metric
      }

      threshold_critical          = 80
      threshold_critical_recovery = 70
      renotify_interval           = 60
    } if monitor.enabled_service_monitor == true
  }

  error_hit_monitors = {
    for service_name, monitor in var.service_names :
    "p95_${service_name}" => {
      priority_level = 3
      title_tags     = "[High Error Hits]"
      title          = "Service ${service_name} Error Hits is high"

      query_template = "percentile($${timeframe}):p95:$${metric}{env:${var.environment},service:${service_name}}.as_count() > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
        metric    = local.error_hit_metric
      }

      threshold_critical          = 80
      threshold_critical_recovery = 70
      renotify_interval           = 60
    } if monitor.enabled_service_monitor == true
  }

  p95_metric         = "trace.fastapi.request"
  request_hit_metric = "trace.fastapi.request.hits"
  error_hit_metric   = "trace.fastapi.request.errors"
}
