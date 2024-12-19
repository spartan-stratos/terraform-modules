data "aws_iam_policy_document" "this" {
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

resource "aws_kms_key_policy" "this" {
  key_id = aws_kms_key.this.id
  policy = data.aws_iam_policy_document.encrypt_decrypt.json
}

data "aws_iam_policy_document" "encrypt_decrypt" {
  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt"
    ]
    resources = [aws_kms_key.this.arn]
  }
}


resource "aws_iam_policy" "this" {
  for_each = toset(var.alias_name)
  name     = "KMSEncryptDecrypt-${each.value}"

  policy = data.aws_iam_policy_document.encrypt_decrypt.json
}
