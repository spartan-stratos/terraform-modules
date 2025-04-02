resource "kubernetes_manifest" "this" {
  for_each = var.projects
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"

    metadata = {
      namespace = var.argocd_namespace
      name      = each.value.project_name
    }

    spec = {
      description  = each.value.description
      sourceRepos  = ["*"]
      destinations = each.value.destinations
      roles = [
        for group, roles in var.group_roles : {
          name     = group
          groups   = ["${var.github_app.organization}:${group}"]
          policies = [for role in roles : "p, proj:${each.value.project_name}:${group}, ${role}"]
        }
      ]
    }
  }
}

resource "kubernetes_secret" "repo" {
  metadata {
    namespace = var.argocd_namespace
    name      = "github-repo-${var.repo_name}"

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    type                    = "git"
    url                     = "https://github.com/${var.github_app.organization}/${var.repo_name}"
    githubAppInstallationID = var.github_app.installation_id
  }
}
