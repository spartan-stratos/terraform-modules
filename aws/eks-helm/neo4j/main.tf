resource "random_password" "neo4j_password" {
  count   = var.neo4j_password == null ? 1 : 0
  length  = 24
  special = false
}

locals {
  manifest = <<-YAML
ingress:
  enabled: true
  annotations:
    alb.ingress.kubernetes.io/group.name: external
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/target-type: "ip"
    alb.ingress.kubernetes.io/healthcheck-path: "/api/health/"
    alb.ingress.kubernetes.io/scheme:  "internet-facing"
    alb.ingress.kubernetes.io/listen-ports: "[{\"HTTP\": 80}, {\"HTTPS\": 443}]"
  hostname: ${local.neo4j_fqdn}
  extraRules:
    - host: ${local.neo4j_fqdn}
      http:
        paths:
          - path: /
            pathType: ImplementationSpecific
            backend:
              service:
                name: neo4j
                port:
                  name: http
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
  create_namespace = true
  namespace        = var.namespace
  force_update     = true
  timeout          = 1000

  values = [local.manifest]

  depends_on = [kubernetes_persistent_volume.neo4j_home]

  lifecycle {
    ignore_changes = [
      timeout
    ]
  }
}
