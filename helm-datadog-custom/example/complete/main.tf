module "helm_datadog" {
  source = "../../"

  environment       = "dev"
  datadog_api_key   = "your-datadog-api-key"
  datadog_app_key   = "your-datadog-app-key"
  datadog_image_tag = "7.58.0"
  cloud_provider    = "gke-autopilot"

  namespace         = "datadog"
  helm_release_name = "datadog"

  deployment_replicas           = 1
  deployment_cpu                = "250m"
  deployment_memory             = "512Mi"
  rolling_agent_max_unavailable = "30%"

  remote_config_enabled = false

  http_check_urls = [
    "https://example.com",
  ]

  container_exclude = "kube_namespace:.*"
  container_include = "kube_namespace:^service-.* kube_namespace:^datadog$ name:^controller$"
}
