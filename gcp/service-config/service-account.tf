module "service_account" {
  source = "../service-account"

  project_id                 = var.project_id
  service_account_id         = "${var.name}-${var.environment}"
  enabled_create_custom_role = var.create_custom_role
  roles                      = var.roles
  permissions                = var.permissions
}
