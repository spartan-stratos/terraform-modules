locals {
  keda_role_arn = var.enabled_aws_irsa ? aws_iam_role.this[0].arn : ""
}

data "aws_iam_policy_document" "this" {
  count = var.enabled_aws_irsa ? 1 : 0
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider.url}:sub"
      values   = ["system:serviceaccount:${var.namespace}:keda-operator"]
    }
  }
}

resource "aws_iam_role" "this" {
  count              = var.enabled_aws_irsa ? 1 : 0
  name               = var.keda_operator_role_name
  assume_role_policy = data.aws_iam_policy_document.this[0].json
}

data "aws_iam_policy_document" "assume-role-policy-document" {
  count = var.enabled_aws_irsa ? 1 : 0
  statement {
    sid    = "sts"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    resources = var.assume_role_arns
  }
}

resource "aws_iam_role_policy" "assume-role-policy" {
  count  = var.enabled_aws_irsa ? 1 : 0
  name   = "assume-role-policy"
  role   = aws_iam_role.this[0].id
  policy = data.aws_iam_policy_document.assume-role-policy-document[0].json
}
