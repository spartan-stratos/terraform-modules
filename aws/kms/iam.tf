resource "aws_iam_policy" "encrypt_decrypt" {
  count       = var.enabled_create_policy ? 1 : 0
  description = "Policy that allows encrypt and decrypt data with the provided encryption KMS key."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "kms:Encrypt",
          "kms:Decrypt"
        ]
        Effect = "Allow"
      },
    ]
  })
}
