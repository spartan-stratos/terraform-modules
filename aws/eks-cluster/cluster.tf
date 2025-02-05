resource "aws_eks_cluster" "master" {
  name     = local.cluster_name
  role_arn = aws_iam_role.master.arn

  # access_config {
  #   authentication_mode = (
  #     var.enabled_config_map ? "CONFIG_MAP" :
  #     var.enabled_api ? "API" :
  #     var.enabled_api_and_config_map ? "API_AND_CONFIG_MAP" :
  #     "CONFIG_MAP"
  #   )
  # }

  vpc_config {
    security_group_ids      = concat(var.security_group_ids, tolist([aws_security_group.cluster.id]))
    subnet_ids              = concat(var.private_subnet_ids, var.public_subnet_ids)
    endpoint_private_access = var.enabled_endpoint_private_access
    endpoint_public_access  = var.enabled_endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types

  version = var.cluster_version

  tags = {
    "karpenter.sh/discovery" = local.cluster_name
  }
}
