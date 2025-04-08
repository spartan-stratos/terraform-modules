resource "helm_release" "this" {
  name             = "argocd"
  namespace        = var.argocd_namespace
  repository       = var.chart_url
  chart            = "argo-cd"
  version          = var.chart_version
  max_history      = 3
  create_namespace = true
  values           = [local.manifest]
}

resource "kubernetes_secret" "github_app" {
  metadata {
    namespace = var.argocd_namespace
    name      = var.github_app.secret_name

    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    type                = "git"
    url                 = "https://github.com/${var.github_app.organization}"
    githubAppID         = var.github_app.app_id
    githubAppPrivateKey = var.github_app.private_key
  }
}
