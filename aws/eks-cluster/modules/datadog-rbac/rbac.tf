locals {
  service_accounts = merge(
    {
      default     = distinct(concat(["default"], [var.default_service_account])),
      kube-system = "kube-system"
    },
    var.custom_service_accounts,
    {
      for namespace in var.custom_namespaces : namespace => namespace
    }
  )
}

resource "kubernetes_cluster_role" "datadog_agent" {
  metadata {
    name = var.datadog_agent_cluster_role_name
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "namespaces", "endpoints"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["nodes/metrics", "nodes/spec", "nodes/stats", "nodes/proxy", "nodes/pods", "nodes/healthz"]
    verbs      = ["get"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "datadog_agent" {
  for_each = local.service_accounts

  metadata {
    name = "${var.datadog_agent_cluster_role_name}-${each.key}"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.datadog_agent_cluster_role_name
  }

  dynamic "subject" {
    for_each = each.value
    content {
      kind      = "ServiceAccount"
      name      = subject.value
      namespace = each.key
    }
  }

  depends_on = [kubernetes_cluster_role.datadog_agent]
}
