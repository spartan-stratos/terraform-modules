output "key_id" {
  value = module.kms.key_id
}

output "key_arn" {
  value = module.kms.key_arn
}

output "key_alias" {
  value = module.kms.key_alias
}

output "iam_policy" {
  value = module.kms.iam_policy_kms_encrypt_decrypt_arn
}
