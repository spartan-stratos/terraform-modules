resource "kubernetes_cluster_role" "cluster-role" {
  metadata {
    name = var.cluster_role_name
  }

  rule {
    api_groups = [""]
    resources  = ["nodes/metrics", "nodes/stats"]
    verbs      = ["get"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "cluster-role-binding" {
  for_each = local.namespaces

  metadata {
    name = "${var.cluster_role_name}-${each.key}"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.cluster_role_name
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.service_account
    namespace = each.value
  }

  depends_on = [kubernetes_cluster_role.cluster-role]
}
