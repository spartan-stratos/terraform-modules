output "key_id" {
  description = "The ID of the KMS key."
  value       = module.kms.key_id
}

output "key_arn" {
  description = "The ARN of the KMS key."
  value       = module.kms.key_arn
}

output "key_alias" {
  description = "The alias name assigned to the KMS key."
  value       = module.kms.key_alias
}

output "iam_policy" {
  description = "The ARN of the IAM policy that grants encrypt and decrypt permissions for the KMS key."
  value       = module.kms.iam_policy_kms_encrypt_decrypt_arn
}