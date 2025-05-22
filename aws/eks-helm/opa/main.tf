##### Metrics Server  ###############################
resource "helm_release" "opa" {
  name       = var.helm_release_name
  repository = "https://spartan-stratos.github.io/helm-charts/"
  chart      = "spartan"
  version    = var.helm_chart_version
  namespace  = var.namespace
  keyring    = ""

  set {
    name = "image.repository"
    value = "openpolicyagent/opa"
  }

  set {
    name = "image.tag"
    value = "1.4.2"
  }

  set {
    name = "containerPort"
    value = 8181
  }

  set_list {
    name  = "args"
    value = ["run", "--ignore=.*", "--server"]
  }
}
