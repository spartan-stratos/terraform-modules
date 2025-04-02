resource "null_resource" "wait_for_crds" {
  provisioner "local-exec" {
    command = "kubectl wait --for=condition=Established --timeout=300s crd/appprojects.argoproj.io"
  }
  depends_on = [helm_release.this]
}

module "argocd_projects" {
  source   = "./modules/argocd-project"
  for_each = var.argocd_projects

  project_name = each.value.project_name
  description  = each.value.description

  github_app = var.github_app

  github_repositories = each.value.github_repositories

  group_roles = var.group_roles
  depends_on = [null_resource.wait_for_crds]
}
