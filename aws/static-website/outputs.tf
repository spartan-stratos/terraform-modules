output "domain_name" {
  description = "The domain name of the site"
  value       = module.cloudfront.domain_name
}

output "s3_bucket_id" {
  description = "The S3 bucket ID that holding the web assets"
  value       = module.s3.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "The S3 bucket arn that holding the web assets"
  value       = module.s3.s3_bucket_arn
}

output "cloudfront_id" {
  description = "The Cloudfront ID that hosting the web"
  value       = module.cloudfront.cloudfront_id
}
