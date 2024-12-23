data "aws_iam_policy_document" "read" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
    ]
    resources = [aws_sqs_queue.queue.arn]
  }
}

data "aws_iam_policy_document" "write" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
    ]
    resources = [aws_sqs_queue.queue.arn]
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
