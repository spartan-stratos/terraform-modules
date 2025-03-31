locals {
  dex_config = {
    connectors = [{
      type = "github"
      id   = "github"
      name = "GitHub"
      config = {
        clientID     = var.oidc_github_client_id
        clientSecret = var.oidc_github_client_secret
        orgs         = [var.oidc_github_organization]
      }
    }]
  }

  release_values = {
    global = {
      domain = "argocd.${var.domain_name}"
    }
    server = {
      ingress = var.enabled_custom_ingress ? {
        enabled          = var.ingress.enabled
        hostname         = "argocd.${var.domain_name}"
        ingressClassName = var.ingress.ingress_class
        controller       = var.ingress.controller
        annotations      = var.ingress.annotations
        path             = var.ingress.path
        pathType         = var.ingress.pathType
        } : {
        enabled          = "true"
        hostname         = "argocd.${var.domain_name}"
        ingressClassName = "alb"
        controller       = "aws"
        annotations = {
          "alb.ingress.kubernetes.io/group.name"       = "external",
          "kubernetes.io/ingress.class"                = "alb"
          "alb.ingress.kubernetes.io/target-type"      = "ip"
          "alb.ingress.kubernetes.io/healthcheck-path" = "/api/health/"
          "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
          "alb.ingress.kubernetes.io/listen-ports"     = "[{\"HTTP\": 80}, {\"HTTPS\": 443}]"
        }
        path     = "/*"
        pathType = "ImplementationSpecific"
      }
    }
    dex = {
      enabled = true
    }
    configs = {
      params = {
        "server.insecure"             = !var.handle_tls
        "controller.diff.server.side" = tostring(var.server_side_diff)
      }
      cm = {
        "dex.config" = yamlencode(local.dex_config)
      }
      rbac = {
        "policy.csv" = join("\n", var.rbac_policies)
      }
      clusterCredentials = var.external_clusters
    }
    notifications = {
      enabled = true
      secret = {
        items = {
          slack-token = var.slack_token
        }
      }
      subscriptions = [{
        recipients = ["slack:social"]
        triggers   = ["on-sync-status-unknown", "app-deployed", "app-sync-failed", "app-sync-running", "app-sync-succeeded"]
      }]

      notifiers = {
        "service.slack" = <<EOT
token: $slack-token
EOT
      }
      templates = local.slack_templates
      triggers  = local.slack_triggers

    }
  }

}

resource "helm_release" "this" {
  name        = "argocd"
  namespace   = var.argocd_namespace
  repository  = var.chart_url
  chart       = "argo-cd"
  version     = var.chart_version
  max_history = 3

  create_namespace = true
  values           = [yamlencode((local.release_values))]
}

resource "kubernetes_secret" "github_app" {
  metadata {
    namespace = var.argocd_namespace
    name      = "argocd-github-app"

    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    type                = "git"
    url                 = "https://github.com"
    githubAppID         = var.github_app.id
    githubAppPrivateKey = var.github_app.private_key
  }
}
