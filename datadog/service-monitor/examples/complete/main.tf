module "service_monitor" {
  source = "../../"

  cluster_name                      = "proj-service-dev"
  service_name                      = "service-platform"
  environment                       = "dev"
  tag_slack_channel                 = false
  notification_slack_channel_prefix = "proj-service-x-"

  pod_monitor_enabled     = true
  cpu_monitor_enabled     = true
  memory_monitor_enabled  = true
  service_monitor_enabled = true
}
