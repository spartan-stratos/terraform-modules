resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = var.namespace
  create_namespace = true
  force_update     = false
  version          = var.chart_version
  values           = [local.manifest]
  timeout          = 1200
}

data "kubernetes_secret" "secrets" {
  metadata {
    name      = "argocd-notifications-secret"
    namespace = var.namespace
  }
}

resource "kubernetes_secret" "slack" {
  metadata {
    name      = "argocd-notifications-secret"
    namespace = var.namespace
    annotations = {
      "meta.helm.sh/release-namespace" = "argocd"
      "meta.helm.sh/release-name"      = "argocd"
    }
    labels = {
      "app.kubernetes.io/component"  = "notifications-controller"
      "app.kubernetes.io/instance"   = "argocd"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "argocd-notifications-controller"
      "app.kubernetes.io/part-of"    = "argocd"
      "app.kubernetes.io/version"    = "v2.14.2"
      "helm.sh/chart"                = "argo-cd-7.8.2"
    }
  }

  data = merge(
    data.kubernetes_secret.secrets.data, # Existing data
    {
      "slack-token" = var.slack_token # New key-value pair
    }
  )

  type = "Opaque"
}

resource "kubernetes_config_map" "slack" {
  metadata {
    name      = "argocd-notifications-cm"
    namespace = var.namespace
    annotations = {
      "meta.helm.sh/release-name"      = "argocd"
      "meta.helm.sh/release-namespace" = "argocd"
    }
    labels = {
      "app.kubernetes.io/component"  = "notifications-controller"
      "app.kubernetes.io/instance"   = "argocd"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/name"       = "argocd-notifications-controller"
      "app.kubernetes.io/part-of"    = "argocd"
      "app.kubernetes.io/version"    = "v2.14.2"
      "helm.sh/chart"                = "argo-cd-7.8.2"
    }
  }
  data = {
    "service.slack"  = <<EOT
token: ${var.slack_token}
EOT
    "template.slack" = <<EOT
text: "Application sync succeeded"
EOT
  }

}

data "kubernetes_secret" "argocd_admin_secret" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = var.namespace
  }
}

resource "kubernetes_secret" "argocd_repo" {
  depends_on = [helm_release.argocd]

  metadata {
    name      = "platform"
    namespace = var.namespace
    annotations = {
      managed-by = "argocd.argoproj.io"
    }
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = [{
    type          = "git"
    project       = "default"
    url           = "git@github.com:spartan-haopham/gitops-demo.git"
    name          = "argocd-app"
    sshPrivateKey = file("${path.module}/github-ssh.pem")
  }]
}
