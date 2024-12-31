resource "datadog_monitor" "llmobs_p95_monitor" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_service_monitor == true
  }

  name     = "[P${lookup(local.llmobs_p95.priority_levels, var.environment)}] [High P95 Latency] [${title(each.key)}] [LLM Observability]: ${upper(var.environment)} - ${title(each.key)} has a tremendous high P95 latency"
  type     = "query alert"
  message  = lookup(local.llmobs_p95.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "percentile(${local.llmobs_p95.timeframe}):p95:ml_obs.span.duration{env:${var.environment}} > ${local.llmobs_p95.critical}"
  priority = lookup(local.llmobs_p95.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.llmobs_p95.critical
    critical_recovery = local.llmobs_p95.critical_recovery
  }

  renotify_interval = local.llmobs_p95.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "llmobs_p95_monitor_o1" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_service_monitor == true
  }

  name     = "[P${lookup(local.llmobs_p95_o1.priority_levels, var.environment)}] [High P95 Latency] [${title(each.key)}] [LLM Observability]: ${upper(var.environment)} - ${title(each.key)} has a tremendous high P95 latency"
  type     = "query alert"
  message  = lookup(local.llmobs_p95_o1.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "percentile(${local.llmobs_p95_o1.timeframe}):p95:ml_obs.span.duration{env:${var.environment}} > ${local.llmobs_p95_o1.critical}"
  priority = lookup(local.llmobs_p95_o1.priority_levels, var.environment)
  monitor_thresholds {
    critical          = local.llmobs_p95_o1.critical
    critical_recovery = local.llmobs_p95_o1.critical_recovery
  }

  renotify_interval = local.llmobs_p95_o1.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:${each.key}"]

  notification_preset_name = local.notification_preset_name
}

resource "datadog_monitor" "llmobs_error_rate_monitor" {
  for_each = {
    for k, v in var.service_names : k => v
    if v.enabled_service_monitor == true
  }

  name     = "[P${lookup(local.error_hit.priority_levels, var.environment)}] [High Errors Rate] [${title(each.key)}] [LLM Observability]: ${upper(var.environment)} - ${title(each.key)} has high error hits"
  type     = "query alert"
  message  = lookup(local.error_hit.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "sum(${local.error_hit.timeframe}):sum:ml_obs.trace.error{env:${var.environment}}.as_count() > ${local.error_hit.critical}"
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
