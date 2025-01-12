module "fargate_profile" {
  source = "../eks-cluster/modules/fargate-profile"
  create = var.create_fargate_profile

  # Fargate Profile
  cluster_name      = var.cluster_name // TODO
  cluster_ip_family = "ipv4"
  name              = "${var.cluster_name}-fargate"
  subnet_ids        = var.private_subnet_ids
  fargate_profiles  = var.fargate_profiles
  timeouts          = var.fargate_timeouts

  tags = {
    Name = "${local.cluster_name}-node"
  }
}

resource "kubernetes_namespace" "fargate" {
  for_each = local.namespaces

  metadata {
    name = each.value
  }
}
