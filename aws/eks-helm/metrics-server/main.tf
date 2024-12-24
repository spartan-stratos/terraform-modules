##### Metrics Server  ###############################
resource "helm_release" "metrics_server" {
  name       = var.helm_release_name
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = var.helm_chart_version
  namespace  = var.namespace
  keyring    = ""

  set {
    name  = "metrics.enabled"
    value = false
  }
}
