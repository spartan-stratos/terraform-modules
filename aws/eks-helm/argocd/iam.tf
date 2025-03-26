locals {
  assumeRoles = [for cluster in values(var.external_clusters) : cluster.assumeRole]
}

data "aws_iam_policy_document" "assume_role_policy" {
  count = var.enabled_aws_management_role ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [var.aws_management_role.eks_oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.aws_management_role.eks_oidc_provider_arn}:sub"
      values = [
        "system:serviceaccount:${var.namespace}:argocd-application-controller",
        "system:serviceaccount:${var.namespace}:argocd-applicationset-controller",
        "system:serviceaccount:${var.namespace}:argocd-server",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.aws_management_role.eks_oidc_provider_arn}:aud"
      values = [
        "sts.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "allow_assume_remote_role" {
  count = var.enabled_aws_management_role ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]

    resources = local.assumeRoles
  }

}

resource "aws_iam_role" "this" {
  count = var.enabled_aws_management_role ? 1 : 0

  name               = var.aws_management_role.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy[0].json
}

resource "aws_iam_role_policy" "this" {
  count = var.enabled_aws_management_role ? 1 : 0

  role   = aws_iam_role.this[0].name
  policy = data.aws_iam_policy_document.allow_assume_remote_role[0].json
}
