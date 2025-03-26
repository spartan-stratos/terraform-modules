locals {
  dex_config = {
    connectors = [{
      type = "github"
      id   = "github"
      name = "GitHub"
      config = {
        clientID     = var.oidc_github_client_id
        clientSecret = var.oidc_github_client_secret
        orgs         = [for org in var.oidc_github_orgs : { name = org }]
      }
    }]
  }

  release_values = {
    global = {
      domain = var.ingress.hostname
    }
    server = {
      ingress = var.enabled_alb_ingress ? {
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
        path = "/*"
        pathType = "ImplementationSpecific"
        } : {
        enabled          = var.ingress.enabled
        hostname         = "argocd.${var.domain_name}"
        ingressClassName = var.ingress.ingress_class
        controller       = var.ingress.controller
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
  namespace   = var.namespace
  repository  = var.chart_url
  chart       = "argo-cd"
  version     = var.chart_version
  max_history = 3

  create_namespace = true
  values           = [yamlencode((local.release_values))]
}

resource "kubernetes_secret" "github_app" {
  metadata {
    namespace = var.namespace
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
