module "rbac" {
  source = "./modules/rbac"

  count = var.set_rbac_create != null ? 1 : 0

  service_account = "metrics-server"
}