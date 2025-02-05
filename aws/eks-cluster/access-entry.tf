resource "aws_eks_access_entry" "node_role" {
  count = var.enabled_api || var.enabled_api_and_config_map ? 1 : 0

  cluster_name  = local.cluster_name
  principal_arn = aws_iam_role.node.arn
}

resource "aws_eks_access_policy_association" "node_role" {
  count = var.enabled_api || var.enabled_api_and_config_map ? 1 : 0

  cluster_name = local.cluster_name

  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_iam_role.node.arn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "auth_role" {
  count = var.enabled_api || var.enabled_api_and_config_map ? 1 : 0

  cluster_name  = local.cluster_name
  principal_arn = aws_iam_role.auth_role.arn
}

resource "aws_eks_access_policy_association" "auth_role" {
  count = var.enabled_api || var.enabled_api_and_config_map ? 1 : 0

  cluster_name = local.cluster_name

  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_iam_role.auth_role.arn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "fargate_profile" {
  count = var.enabled_api || var.enabled_api_and_config_map ? 1 : 0

  cluster_name  = local.cluster_name
  principal_arn = module.fargate_profile.fargate_profile_pod_execution_role_arn
}

resource "aws_eks_access_policy_association" "fargate_profile" {
  count = var.enabled_api || var.enabled_api_and_config_map ? 1 : 0

  cluster_name = local.cluster_name

  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = module.fargate_profile.fargate_profile_pod_execution_role_arn

  access_scope {
    type = "cluster"
  }
}
