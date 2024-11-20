output "s3_bucket_id" {
  description = "The unique ID of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.main.bucket
}

output "s3_bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}

output "iam_policy_s3_bucket_public_assets_write_arn" {
  description = "The ARN of the IAM policy granting write access to public assets"
  value       = aws_iam_policy.main.arn
}

output "iam_policy_s3_bucket_assets_read_only_arn" {
  description = "The ARN of the IAM policy granting read-only access to the S3 bucket assets"
  value       = aws_iam_policy.readonly.arn
}

