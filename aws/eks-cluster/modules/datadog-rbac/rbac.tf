locals {
  namespaces = merge({ for namespace in var.custom_namespaces : namespace => namespace }, { default = "default", "kube-system" = "kube-system" })
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
  for_each = local.namespaces

  metadata {
    name = "${var.datadog_agent_cluster_role_name}-${each.key}"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.datadog_agent_cluster_role_name
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.default_service_account
    namespace = each.value
  }

  depends_on = [kubernetes_cluster_role.datadog_agent]
}
