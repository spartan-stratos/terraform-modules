module "resource" {
  source = "../monitors"

  notification_slack_channel_prefix = var.notification_slack_channel_prefix
  tag_slack_channel                 = var.tag_slack_channel
  environment                       = var.environment
  service                           = "resource"

  monitors = {
    for monitor, config in local.default_resource_monitors :
    monitor => merge(config, try(var.override_default_monitors[monitor], {})) if var.create_resource_monitors
  }
}
