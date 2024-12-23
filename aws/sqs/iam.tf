data "aws_iam_policy_document" "read" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
    ]
    resources = [
      "arn:aws:sqs:${local.aws_region}:${local.aws_account_id}:${local.queue_name}"
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
      "arn:aws:sqs:${local.aws_region}:${local.aws_account_id}:${local.queue_name}"
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
