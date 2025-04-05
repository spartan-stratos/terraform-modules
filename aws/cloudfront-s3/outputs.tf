output "cloudfront_id" {
  description = "The Cloudfront ID that hosting the web"
  value       = aws_cloudfront_distribution.this.id
}
