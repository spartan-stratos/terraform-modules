module "example" {
  source = "../../"

  helm_release_name  = "metrics-server"
  namespace          = "kube-system"
  helm_chart_version = "3.12.2"
}


module "metrics_server_with_rbac" {
  source = "../../"

  helm_release_name  = "metrics-server"
  namespace          = "kube-system"
  helm_chart_version = "3.12.2"

  set_rbac_create = {
    name  = "rbac.create"
    value = true
  }

  set_container_port = {
    name  = "containerPort"
    value = 10250
  }
  create_eks_rbac = true

  set_list_config = [{
    name = "defaultArgs"
    value = [
      "--cert-dir=/tmp",
      "--secure-port=10250",
      "--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",
      "--kubelet-insecure-tls",
      "--metric-resolution=15s"
    ]
  }]
}
