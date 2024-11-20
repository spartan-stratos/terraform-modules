module "datadog_rbac" {
  count                   = var.create_fargate_profile == true && var.enabled_datadog_agent == true ? 1 : 0
  source                  = "./modules/datadog-rbac"
  fargate_profiles        = var.fargate_profiles
  default_service_account = var.default_service_account
  custom_namespaces       = var.custom_namespaces
}
