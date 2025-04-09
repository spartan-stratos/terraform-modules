output "ingress_controller_namespace" {
  value = helm_release.this.namespace
}

output "ingress_controller_service_name" {
  value = data.kubernetes_service.this.metadata[0].name
}
