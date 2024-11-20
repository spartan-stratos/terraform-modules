resource "aws_eks_cluster" "master" {
  name     = local.cluster_name
  role_arn = aws_iam_role.master.arn

  vpc_config {
    security_group_ids      = concat(var.security_group_ids, tolist([aws_security_group.cluster.id]))
    subnet_ids              = concat(var.private_subnet_ids, var.public_subnet_ids)
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types

  version = var.cluster_version

  tags = {
    "karpenter.sh/discovery" = local.cluster_name
  }
}