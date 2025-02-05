locals {
  fargate_profile_pod_execution_role_arn = module.fargate_profile.fargate_profile_pod_execution_role_arn

  aws_auth_configmap_data = {
    mapRoles = yamlencode(concat(
      [{
        rolearn  = aws_iam_role.node.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes",
        ]
        }
      ]
      ,
      [{
        rolearn  = aws_iam_role.auth_role.arn
        username = "master-role"
        groups = [
          "system:masters",
        ]
        }
      ]
      ,
      [{
        rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/jenkins-oidc-role"
        username = "oidc-role"
        groups = [
          "system:masters",
        ]
        }
      ]
      ,
      # Fargate profile
      [{
        rolearn  = local.fargate_profile_pod_execution_role_arn
        username = "system:node:{{SessionName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes",
          "system:node-proxier",
        ]
        }
      ]
    ))
    mapUsers    = yamlencode(var.aws_auth_users)
    mapAccounts = yamlencode(var.aws_auth_accounts)
  }
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  count = anytrue([var.enabled_api_and_config_map, var.enabled_config_map]) ? 1 : 0
  force = true

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = local.aws_auth_configmap_data

  lifecycle {
    ignore_changes = [
      data
    ]
  }

  depends_on = [
    aws_eks_node_group.default,
    module.fargate_profile
  ]
}
