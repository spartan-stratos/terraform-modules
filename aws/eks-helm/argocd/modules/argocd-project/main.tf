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
      sourceRepos  = var.restrict_source_repos
      destinations = var.restrict_destinations
      roles = [
        for group, roles in var.project_group_roles : {
          name     = group
          groups   = ["${var.github_organization}:${group}"]
          policies = [for role in roles : "p, proj:${var.project_name}:${group}, ${role}"]
        }
      ]
    }
  }
}

resource "kubernetes_secret" "repo" {
  for_each = var.github_repositories
  metadata {
    namespace = var.argocd_namespace
    name      = "github-repo-${var.project_name}-${each.key}"

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    type = "git"
    # project                 = var.project_name
    url                     = "https://github.com/${var.github_organization}/${each.key}"
    githubAppInstallationID = var.argo_app_installation_id
  }
}

resource "kubernetes_secret" "app" {
  count = var.enabled_custom_github_app ? 1 : 0

  metadata {
    namespace = var.argocd_namespace
    name      = "github-app-${var.project_name}"

    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    type                    = "git"
    url                     = "https://github.com/${var.github_organization}"
    githubAppID             = var.github_app.id
    githubAppInstallationID = var.github_app.installation_id
    githubAppPrivateKey     = var.github_app.private_key
  }
}
