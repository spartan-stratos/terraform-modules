##### Metrics Server  ###############################
resource "helm_release" "metrics_server" {
  name       = var.helm_release_name
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = var.helm_chart_version
  namespace  = var.namespace
  keyring    = ""

  # If true, allow unauthenticated access to /metrics.
  dynamic "set" {
    for_each = var.set_metrics_enabled == null ? [] : [var.set_metrics_enabled]
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set" {
    for_each = var.set_container_port == null ? [] : [var.set_container_port]
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set" {
    for_each = var.set_rbac_create == null ? [] : [var.set_rbac_create]
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set_list" {
    for_each = var.set_list_config

    content {
      name  = set_list.value.name
      value = set_list.value.value
    }
  }
}
