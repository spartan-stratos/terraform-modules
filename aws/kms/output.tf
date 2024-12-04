output "key_id" {
  value = aws_kms_key.this.arn
}

output "key_arn" {
  value = aws_kms_key.this.arn
}

output "key_alias" {
  value = aws_kms_alias.this.id
}

output "iam_policy_kms_encrypt_decrypt_arn" {
  value = try(aws_iam_policy.encrypt_decrypt.0.arn, null)
}
