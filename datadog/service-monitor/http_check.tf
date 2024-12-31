resource "datadog_monitor" "http_check_monitor" {
  name     = "[P${lookup(local.http_check.priority_levels, var.environment)}] [HTTP Check]: ${upper(var.environment)} - URLs are NOT healthy"
  type     = "service check"
  message  = lookup(local.http_check.priority_levels, var.environment) >= 4 ? "" : local.message
  query    = "\"http.can_connect\".over(\"env:${var.environment}\").by(\"url\").last(2).count_by_status()"
  priority = lookup(local.http_check.priority_levels, var.environment)
  monitor_thresholds {
    critical = local.http_check.critical
    ok       = local.http_check.ok
  }

  renotify_interval = local.http_check.renotify_interval
  renotify_statuses = ["alert"]
  timeout_h         = 1

  include_tags = local.enabled_include_tags
  tags         = ["env:${var.environment}", "service:http_check"]

  notification_preset_name = local.notification_preset_name
}
