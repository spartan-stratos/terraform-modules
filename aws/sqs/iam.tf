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
  name        = var.read_policy_name != null ? var.read_policy_name : "SQSRead-${var.name}"
  description = "Policy that allows receive message from a shared queue."
  policy      = data.aws_iam_policy_document.read.json
}

resource "aws_iam_policy" "write" {
  name        = var.write_policy_name != null ? var.write_policy_name : "SQSWrite-${var.name}"
  description = "Policy that allows send message from a shared queue."
  policy      = data.aws_iam_policy_document.write.json
}
