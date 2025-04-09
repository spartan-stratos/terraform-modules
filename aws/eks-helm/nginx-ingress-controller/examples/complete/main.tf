module "example" {
  source = "../.."

  network_cidr = "10.1.0.0/16"

  nginx_cpu    = "100m"
  nginx_memory = "90Mi"

  replicas    = 1
  minReplicas = 1
  maxReplicas = 3

  ingress_group_name = "external"
  ingress_class_name = "alb"
}
