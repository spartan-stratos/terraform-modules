data "aws_eks_addon_version" "vpc_cni_latest" {
  addon_name         = "vpc-cni"
  kubernetes_version = aws_eks_cluster.master.version
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = local.cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = data.aws_eks_addon_version.vpc_cni_latest.version
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [aws_eks_cluster.master]
}

data "aws_eks_addon_version" "kube_proxy_latest" {
  addon_name         = "kube-proxy"
  kubernetes_version = aws_eks_cluster.master.version
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = local.cluster_name
  addon_name                  = "kube-proxy"
  addon_version               = data.aws_eks_addon_version.kube_proxy_latest.version
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [aws_eks_cluster.master]
}

data "aws_eks_addon_version" "coredns_latest" {
  addon_name         = "coredns"
  kubernetes_version = aws_eks_cluster.master.version
}

resource "aws_eks_addon" "coredns_ec2" {
  count = var.k8s_core_dns_compute_type == "ec2" ? 1 : 0

  addon_name                  = "coredns"
  addon_version               = data.aws_eks_addon_version.coredns_latest.version
  cluster_name                = local.cluster_name
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [aws_eks_cluster.master]
}

resource "aws_eks_addon" "coredns_fargate" {
  count = var.k8s_core_dns_compute_type == "fargate" ? 1 : 0

  addon_name                  = "coredns"
  addon_version               = data.aws_eks_addon_version.coredns_latest.version
  cluster_name                = local.cluster_name
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({
    computeType = "fargate"
  })

  depends_on = [aws_eks_cluster.master, module.fargate_profile]
}