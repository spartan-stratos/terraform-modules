resource "random_password" "cluster_agent_token" {
  length  = 32
  special = false
}

resource "helm_release" "this" {
  name             = var.helm_release_name
  namespace        = var.namespace
  repository       = "https://helm.datadoghq.com"
  chart            = "datadog"
  version          = var.chart_version
  create_namespace = true
  timeout          = var.timeout

  set_sensitive {
    name  = "datadog.apiKey"
    value = var.datadog_api_key
  }
  set_sensitive {
    name  = "datadog.appKey"
    value = var.datadog_app_key
  }
  set_sensitive {
    name  = "datadog.site"
    value = var.datadog_site
  }
  set_sensitive {
    name  = "datadog.clusterName"
    value = var.cluster_name
  }
  set_sensitive {
    name  = "clusterAgent.token"
    value = random_password.cluster_agent_token.result
  }

  values = [
    templatefile("${path.module}/values.yaml.tftpl", {
      http_check_urls = var.http_check_urls,
      environment     = var.environment
    })
  ]
  lifecycle {
    ignore_changes = [
      timeout
    ]
  }
}
