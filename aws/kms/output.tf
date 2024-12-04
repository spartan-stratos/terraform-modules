output "key_id" {
  description = "The ID of the KMS key."
  value       = aws_kms_key.this.arn
}

output "key_arn" {
  description = "The ARN of the KMS key."
  value       = aws_kms_key.this.arn
}

output "key_alias" {
  description = "The alias name assigned to the KMS key."
  value       = aws_kms_alias.this.id
}

output "iam_policy_kms_encrypt_decrypt_arn" {
  description = "The ARN of the IAM policy that grants encrypt and decrypt permissions for the KMS key."
  value       = try(aws_kms_key_policy.this.policy, null)
}
