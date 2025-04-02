resource "kubernetes_manifest" "app" {
  for_each = var.applications
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      namespace = var.argocd_namespace
      name      = each.value.project_name
    }

    spec = {
      project = each.value.project_name

      source = {
        repoURL = each.value.repo_url
        path    = "${each.value.environment}/${each.value.name}"
      }

      syncPolicy = var.sync_policy
    }
  }
}
