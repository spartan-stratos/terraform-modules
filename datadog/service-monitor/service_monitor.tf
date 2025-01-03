module "service" {
  source = "../monitors"

  notification_slack_channel_prefix = var.notification_slack_channel_prefix
  tag_slack_channel                 = var.tag_slack_channel
  environment                       = var.environment
  service                           = "service"

  monitors = {
    for monitor, config in local.default_service_monitors :
    monitor => merge(config, try(var.override_default_monitors[monitor], {})) if var.service_names != null
  }
}
