locals {
  manifest = <<YAML
controller:
  resources:
    requests:
      cpu: ${var.nginx_cpu}
      memory: ${var.nginx_memory}
    limits:
      cpu: ${var.nginx_cpu}
      memory: ${var.nginx_memory}
  admissionWebhooks:
    enabled: ${var.enabled_admission_webhooks}
  replicaCount: ${var.replicas}
  autoscaling:
    enabled: true
    minReplicas: ${var.minReplicas}
    maxReplicas: ${var.maxReplicas}
    targetCPUUtilizationPercentage: 75
    targetMemoryUtilizationPercentage: 75
  image:
    allowPrivilegeEscalation: false
  service:
    type: ClusterIP
  config:
    use-forwarded-headers: "true"
    limit-req-status-code: "429"
    enable-real-ip: "true"
    proxy-real-ip-cidr: "${var.network_cidr}"
    log-format-upstream: |
      $http_x_forwarded_for - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" $request_length $request_time [$proxy_upstream_name] [$proxy_alternative_upstream_name] $upstream_addr $upstream_response_length $upstream_response_time $upstream_status $req_id
    http-snippet: |
      server {
        listen 18080;
        location /nginx_status {
          allow all;
          stub_status on;
        }
        location / {
          return 404;
        }
      }
YAML
}

resource "helm_release" "this" {
  name             = var.helm_release_name
  namespace        = var.namespace
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = var.helm_chart_version
  create_namespace = true
  timeout          = 600
  values           = [local.manifest]
  lifecycle {
    ignore_changes = [
      timeout
    ]
  }
}

data "kubernetes_service" "this" {
  depends_on = [helm_release.this]
  metadata {
    name      = "${var.helm_release_name}-controller"
    namespace = var.namespace
  }
}