/*
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy
https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html
*/
data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principal_roles != null ? var.principal_roles : ["*"]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:PutKeyPolicy",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",

    ]
    resources = [aws_kms_key.this.arn]
  }
  statement {
    
  }
}

resource "aws_kms_key_policy" "this" {
  key_id = aws_kms_key.this.id
  policy = data.aws_iam_policy_document.this.json
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
  for_each    = toset(var.alias_name)
  name        = "KmsEncryptDecrypt-${each.value}"
  description = "Policy that allows encrypt and decrypt data with the provided encryption KMS key."
  policy      = data.aws_iam_policy_document.encrypt_decrypt.json
}
