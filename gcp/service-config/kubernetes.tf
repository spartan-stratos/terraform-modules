/**
https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
 */
resource "kubernetes_namespace_v1" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [metadata]
  }
}

/**
https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map
 */
resource "kubernetes_config_map" "applications_config_map" {
  data = var.config_map

  metadata {
    name      = "${var.name}-config-map"
    namespace = var.namespace
  }

  depends_on = [kubernetes_namespace_v1.this]
}

/**
https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret
 */
resource "kubernetes_secret" "applications_secret" {
  data = var.secrets
  type = "Opaque"

  metadata {
    name      = "${var.name}-secret"
    namespace = var.namespace
  }

  depends_on = [kubernetes_namespace_v1.this]
}
