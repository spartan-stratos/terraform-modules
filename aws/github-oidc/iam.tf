data "aws_iam_policy_document" "assume_role_github" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${var.aws_account_id}:root"]
      type        = "AWS"
    }
  }

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      identifiers = [local.github_oidc_provider_arn]
      type        = "Federated"
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${local.github_oidc_provider_url}:aud"
    }

    dynamic "condition" {
      for_each = var.conditions

      content {
        test     = each.value.test
        variable = each.value.variable
        values   = each.value.values
      }
    }

  }
}

resource "aws_iam_role" "github_actions_role" {
  name               = "role-terraform-ops-${var.role_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_github.json
}

resource "aws_iam_role_policy_attachment" "github_actions_role_policy" {
  for_each   = toset(var.role_policy_arns)
  role       = aws_iam_role.github_actions_role.id
  policy_arn = each.value
}

