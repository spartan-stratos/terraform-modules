data "aws_iam_policy_document" "encrypt_decrypt" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principal_roles != null ? var.principal_roles : ["*"]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt"
    ]
    resources = [aws_kms_key.this.arn]
  }
}

resource "aws_iam_policy" "this" {
  name = "KMSEncryptDecrypt-${var.alias_name[0]}"

  policy = data.aws_iam_policy_document.encrypt_decrypt.json
}