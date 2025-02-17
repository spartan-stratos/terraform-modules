data "aws_iam_policy_document" "this" {
  for_each = { for k, v in var.access_entries : k => v if v.trusted_role_arn != null }

  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = each.value.trusted_role_arn
    }
  }
}
