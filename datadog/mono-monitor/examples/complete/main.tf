module "mono_monitor" {
  source = "../../"

  notification_slack_channel_prefix = "proj-service-x-"
  environment                       = "dev"
  tag_slack_channel                 = false
  cluster_name                      = "proj-service-dev"

  pod_monitor_enabled = true
  http_check_enabled  = true
}
