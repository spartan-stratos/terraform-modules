output "domain_name" {
  value = aws_route53_record.this.fqdn
}

output "cloudfront_id" {
  description = "The Cloudfront ID that hosting the web"
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "The CloudFront distribution's arn."
  value       = aws_cloudfront_distribution.this.arn
}
