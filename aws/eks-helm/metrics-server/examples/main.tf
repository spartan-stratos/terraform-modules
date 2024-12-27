module "example" {
  source = "../"

  helm_release_name  = "metrics-server"
  namespace          = "kube-system"
  helm_chart_version = "3.12.2"
}


module "metrics_server_with_rbac" {
  source = "../"

  helm_release_name  = "metrics-server"
  namespace          = "kube-system"
  helm_chart_version = "3.12.2"

  set_rbac_create = {
    name  = "rbac.create"
    value = true
  }
}