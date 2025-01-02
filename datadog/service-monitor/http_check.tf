module "http_check" {
  source = "../monitors"

  notification_slack_channel_prefix = var.notification_slack_channel_prefix
  tag_slack_channel                 = var.tag_slack_channel
  environment                       = var.environment
  service                           = "http_check"

  monitors = {
    for monitor, config in local.default_http_check_monitors :
    monitor => merge(config, try(var.override_default_monitors[monitor], {})) if contains(var.enabled_modules, "http_check")
  }
}

locals {
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
}
