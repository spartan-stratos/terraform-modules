locals {
  manifest = <<-YAML
podIdentity:
  aws:
    irsa:
      enabled: ${var.enabled_aws_irsa}
      roleArn: ${local.keda_role_arn}
resources:
  operator:
    limits:
      cpu: ${var.operator_cpu}
      memory: ${var.operator_memory}
    requests:
      cpu: ${var.operator_cpu}
      memory: ${var.operator_memory}
  metricServer:
    limits:
      cpu: ${var.metric_server_cpu}
      memory: ${var.metric_server_memory}
    requests:
      cpu: ${var.metric_server_cpu}
      memory: ${var.metric_server_memory}
  webhooks:
    limits:
      cpu: ${var.admission_webhook_server_cpu}
      memory: ${var.admission_webhook_server_memory}
    requests:
      cpu: ${var.admission_webhook_server_cpu}
      memory: ${var.admission_webhook_server_memory}
YAML
}



resource "helm_release" "keda" {
  name             = var.helm_release_name
  chart            = "keda"
  repository       = "https://kedacore.github.io/charts"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [local.manifest]

  set {
    name  = "podIdentity.aws.irsa.enabled"
    value = "true"
  }

  set {
    name  = "podIdentity.aws.irsa.roleArn"
    value = aws_iam_role.keda-operator.arn
  }

  lifecycle {
    ignore_changes = [
      timeout
    ]
  }
}
