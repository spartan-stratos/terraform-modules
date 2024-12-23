output "external_alb_cname" {
  value = kubernetes_ingress_v1.external_alb.status.0.load_balancer.0.ingress.0.hostname
}

output "external_group_name" {
  value = kubernetes_ingress_v1.external_alb.metadata.0.annotations["alb.ingress.kubernetes.io/group.name"]
}

output "internal_alb_cname" {
  value = try(kubernetes_ingress_v1.internal_alb[0].status.0.load_balancer.0.ingress.0.hostname, null)
}

output "internal_group_name" {
  value = try(kubernetes_ingress_v1.internal_alb[0].metadata.0.annotations["alb.ingress.kubernetes.io/group.name"], null)
}
