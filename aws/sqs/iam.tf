data "aws_iam_policy_document" "read" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
    ]
    resources = [
      "arn:aws:sqs:${var.aws_region}:${var.aws_account_id}:*",
    ]
  }
}

data "aws_iam_policy_document" "write" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
    ]
    resources = [
      "arn:aws:sqs:${var.aws_region}:${var.aws_account_id}:*",
    ]
  }
}

resource "aws_iam_policy" "read" {
  name        = "SqsRead-${var.name}"
  description = "Policy that allows receive message from a shared queue."
  policy      = data.aws_iam_policy_document.read.json
}

resource "aws_iam_policy" "write" {
  name        = "SqsWrite-${var.name}"
  description = "Policy that allows send message from a shared queue."
  policy      = data.aws_iam_policy_document.write.json
}
