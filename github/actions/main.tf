module "action-secret" {
  source = "./modules/action-secrets"

  for_each   = var.repository_secrets
  repository = each.key
  secrets    = each.value
}

module "action-variables" {
  source = "./modules/action-variables"

  for_each   = var.repository_variables
  repository = each.key
  variables  = each.value
}
