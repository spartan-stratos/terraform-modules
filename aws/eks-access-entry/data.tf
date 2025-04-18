data "aws_iam_policy_document" "this" {
  for_each = toset(var.assume_role)

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