module "rbac" {
  source = "./modules/rbac"

  count = var.create_eks_rbac ? 1 : 0

  service_account = "metrics-server"
}
