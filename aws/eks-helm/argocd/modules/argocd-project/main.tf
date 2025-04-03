resource "kubernetes_manifest" "this" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"

    metadata = {
      namespace = var.argocd_namespace
      name      = var.project_name
    }

    spec = {
      description  = var.description
      sourceRepos  = ["*"]
      destinations = var.destinations
      roles = [
        for group, roles in var.group_roles : {
          name     = group
          groups   = ["${var.github_organization}:${group}"]
          policies = [for role in roles : "p, proj:${var.project_name}:${group}, ${role}"]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      namespace = var.argocd_namespace
      name      = var.cluster_name
    }

    spec = {
      project = var.project_name

      source = {
        repoURL        = var.repo_url
        path           = var.path
        targetRevision = var.target_revision
        directory = {
          recurse = true
        }
      }
      syncPolicy = var.sync_policy
    }
  }
  depends_on = [kubernetes_manifest.this]
}
