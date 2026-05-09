locals {
  manifest = <<YAML
datadog:
  containerExclude: "${var.container_exclude}"
  containerInclude: "${var.container_include}"
  logs:
    enabled: true
    autoMultiLineDetection: true
  apm:
    enabled: true
    portEnabled: true
    socketEnabled: false
  kubeStateMetricsEnabled: false
  kubeStateMetricsCore:
    enabled: true
  dogstatsd:
    port: 8125
    useHostPort: false
    nonLocalTraffic: true
  remoteConfiguration:
    enabled: ${var.remote_config_enabled}
agents:
  image:
    tag: ${var.datadog_image_tag}
  deployment:
    enabled: true
    replicas: ${var.deployment_replicas}
    resources:
      limits:
        cpu: ${var.deployment_cpu}
        memory: ${var.deployment_memory}
      requests:
        cpu: ${var.deployment_cpu}
        memory: ${var.deployment_memory}
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: ${var.rolling_agent_max_unavailable}
  containers:
    agent:
      resources:
        limits:
          cpu: 100m
          memory: 200Mi
        requests:
          cpu: 100m
          memory: 200Mi
    processAgent:
      resources:
        limits:
          cpu: 50m
          memory: 100Mi
        requests:
          cpu: 50m
          memory: 100Mi
    traceAgent:
      resources:
        limits:
          cpu: 100m
          memory: 200Mi
        requests:
          cpu: 100m
          memory: 200Mi
clusterAgent:
  enabled: true
  image:
    tag: ${var.datadog_image_tag}
  metricsProvider:
    enabled: true
  resources:
    limits:
      cpu: 250m
      memory: 512Mi
    requests:
      cpu: 250m
      memory: 512Mi
  confd:
    http_check.yaml: |-
      cluster_check: true
      init_config:
      instances: %{for url in var.http_check_urls}
        - name: ${url}
          url: ${url}
          tags:
            - env:${var.environment}
providers:
  gke:
    autopilot: ${var.cloud_provider == "gke-autopilot"}
    cos: ${var.cloud_provider == "gke-cos"}
  eks:
    ec2:
      useHostnameFromFile: ${var.cloud_provider == "eks"}
  aks:
    enabled: ${var.cloud_provider == "aks"}

YAML
}

resource "helm_release" "this" {
  name             = var.helm_release_name
  namespace        = var.namespace
  repository       = "https://spartan-stratos.github.io/helm-charts/"
  chart            = "datadog"
  version          = "0.1.0"
  create_namespace = true
  timeout          = var.timeout

  set_sensitive = [
    {
      name  = "datadog.apiKey"
      value = var.datadog_api_key
    },
    {
      name  = "datadog.appKey"
      value = var.datadog_app_key
    },
  ]

  values = [local.manifest]

  lifecycle {
    ignore_changes = [
      timeout,
      repository
    ]
  }
}
