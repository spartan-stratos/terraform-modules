resource "argocd_application" "this" {
  depends_on = [helm_release.argocd]
  for_each   = var.listRepoURL

  metadata {
    name      = each.service_name
    namespace = each.namespace
  }
  spec {
    project = "default"
    source {
      repo_url        = each.repoURL
      target_revision = each.targetRevision
      path            = each.path
      helm {
        value_files = each.value_files
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "argocd"
    }

    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      sync_options = ["Validate=false"]
      retry {
        limit = "5"
        backoff {
          duration     = "30s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }

  }
}
