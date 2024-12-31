resource "datadog_monitor" "p95_monitor" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_service_monitor == true
  }

  name     = "[P${lookup(local.p95.priority_levels, var.environment)}] [High P95 Latency] [${title(each.key)}]: ${upper(var.environment)} - ${title(each.key)} has a tremendous high P95 latency"
  type     = "query alert"
  message  = lookup(local.p95.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "percentile(${local.p95.timeframe}):p95:trace.fastapi.request{env:${var.environment},service:${each.key}} by {resource_name} > ${local.p95.critical}"
  priority = lookup(local.p95.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.p95.critical
    critical_recovery = local.p95.critical_recovery
  }

  renotify_interval = local.p95.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "query_hit_monitor" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_service_monitor == true
  }

  name     = "[P${lookup(local.query_hit.priority_levels, var.environment)}] [High Query Hits] [${title(each.key)}]: ${upper(var.environment)} - ${title(each.key)} has high query hits"
  type     = "query alert"
  message  = lookup(local.query_hit.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "sum(${local.query_hit.timeframe}):sum:trace.fastapi.request.hits{env:${var.environment}, service:${each.key}}.as_count() > ${local.query_hit.critical}"
  priority = lookup(local.query_hit.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.query_hit.critical
    critical_recovery = local.query_hit.critical_recovery
  }

  renotify_interval = local.query_hit.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "error_hit_monitor" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_service_monitor == true
  }

  name     = "[P${lookup(local.error_hit.priority_levels, var.environment)}] [High Query Errors] [${title(each.key)}]: ${upper(var.environment)} - ${title(each.key)} has high error hits"
  type     = "query alert"
  message  = lookup(local.error_hit.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "sum(${local.error_hit.timeframe}):sum:trace.fastapi.request.errors{env:${var.environment}, service:${each.key}}.as_count() > ${local.error_hit.critical}"
  priority = lookup(local.error_hit.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.error_hit.critical
    critical_recovery = local.error_hit.critical_recovery
  }

  renotify_interval = local.error_hit.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}
