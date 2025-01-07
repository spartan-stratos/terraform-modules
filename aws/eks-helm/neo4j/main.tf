resource "random_password" "neo4j_password" {
  count   = var.neo4j_password == null ? 1 : 0
  length  = 24
  special = false
}

locals {
  manifest = <<-YAML
resources:
  requests:
    cpu: ${var.neo4j_cpu}
    memory: ${var.neo4j_memory}
  limits:
    cpu: ${var.neo4j_cpu}
    memory: ${var.neo4j_memory}
ingress:
  enabled: true
  annotations:
    alb.ingress.kubernetes.io/group.name: ${var.ingress_group_name}
    kubernetes.io/ingress.class: ${var.ingress_class_name}
    alb.ingress.kubernetes.io/target-type: "ip"
    alb.ingress.kubernetes.io/scheme: "internet-facing"
    alb.ingress.kubernetes.io/listen-ports: "[{\"HTTP\": 80}, {\"HTTPS\": 443}]"
  hostname: ${local.neo4j_fqdn}
  path: /*
service:
  type: ClusterIP
persistence:
  storageClass: ${var.efs_storage_class_name}
  existingClaim: ${kubernetes_persistent_volume_claim.neo4j_home.metadata.0.name}
  accessModes:
    - ReadWriteMany
YAML
}

resource "helm_release" "neo4j" {
  name             = var.helm_release_name
  chart            = "neo4j"
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  version          = var.chart_version
  create_namespace = var.create_namespace
  namespace        = var.namespace
  force_update     = var.force_update
  timeout          = 1000

  values = [local.manifest]

  depends_on = [kubernetes_persistent_volume.neo4j_home]

  lifecycle {
    ignore_changes = [
      timeout
    ]
  }
}
