resource "datadog_monitor" "high_number_of_errors" {
  count = var.high_number_of_errors != null ? 1 : 0

  type = "error-tracking alert"
  tags = [
    "created_by:terraform",
    "env:${var.environment}",
    "service:${var.high_number_of_errors.service_regex}"
  ]

  query    = <<EOT
"error-tracking("env:${var.environment} service:${var.high_number_of_errors.service_regex} ${var.high_number_of_errors.additional_filter_regex}").source("${var.high_number_of_errors.source}").impact().rollup("count").by("issue.id").last("${var.high_number_of_errors.time_window}") > ${var.high_number_of_errors.critical}"
EOT
  name     = var.high_number_of_errors.name
  priority = var.high_number_of_errors.priority
  message  = var.high_number_of_errors.message

  monitor_thresholds {
    critical          = var.high_number_of_errors.critical
    critical_recovery = var.high_number_of_errors.critical_recovery
  }

  require_full_window = var.require_full_window
}

resource "datadog_monitor" "new_issue" {
  count = var.new_issue != null ? 1 : 0

  type = "error-tracking alert"
  tags = [
    "created_by:terraform",
    "env:${var.environment}",
    "service:${var.new_issue.service_regex}"
  ]

  query    = <<EOT
error-tracking("env:${var.environment} service:${var.new_issue.service_regex} ${var.new_issue.additional_filter_regex}").source("${var.new_issue.source}").new().rollup("count").by("issue.id").last("${var.new_issue.time_window}") > ${var.new_issue.critical}
EOT
  name     = var.new_issue.name
  priority = var.new_issue.priority
  message  = var.new_issue.message

  monitor_thresholds {
    critical          = var.new_issue.critical
    critical_recovery = var.new_issue.critical_recovery
  }

  require_full_window = var.require_full_window
}
