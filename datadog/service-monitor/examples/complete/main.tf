module "service_monitor" {
  source = "../../"

  notification_slack_channel_prefix = "proj-service-x-"
  environment                       = "dev"
  tag_slack_channel                 = false
  cluster_name                      = "proj-service-dev"
  enabled_modules                   = ["http_check", "k8s", "resource", "service"]

  service_names = {
    "service-platform" = {
      enabled_pods_monitor    = true
      enabled_cpu_monitor     = true
      enabled_memory_monitor  = false
      enabled_service_monitor = true
    }
  }
}
