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
