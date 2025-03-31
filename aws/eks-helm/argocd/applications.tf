resource "kubernetes_manifest" "app" {
  for_each = var.applications
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      namespace = var.namespace
      name      = each.value.project_name
    }

    spec = {
      project = each.value.project_name

      source = {
        repoURL = each.value.repo_url
        path    = "${each.value.environment}/${each.value.name}"
      }

      destination = {
        server    = each.value.destination_cluster
        namespace = each.value.namespace
      }

      syncPolicy = var.sync_policy
    }
  }

  depends_on = [module.argocd_projects]
}