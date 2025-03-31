module "argocd_projects" {
  source   = "./modules/argocd-project"
  for_each = var.argocd_projects

  project_name = each.value.project_name
  description  = each.value.description

  github_organization      = each.value.github_organization
  github_repositories      = each.value.github_repositories
  argo_app_installation_id = each.value.argocd_app_installation_id

  depends_on = [helm_release.this]
}
