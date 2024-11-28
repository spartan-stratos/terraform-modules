resource "aws_iam_policy" "read" {
  name        = "SqsRead-${var.name}"
  description = "Policy that allows receive message from a shared queue."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:ReceiveMessage",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:sqs:${var.aws_region}:${var.aws_account_id}:*",
        ]
      },
    ]
  })
}

resource "aws_iam_policy" "write" {
  name        = "SqsWrite-${var.name}"
  description = "Policy that allows send message from a shared queue."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:sqs:${var.aws_region}:${var.aws_account_id}:*",
        ]
      },
    ]
  })
}
