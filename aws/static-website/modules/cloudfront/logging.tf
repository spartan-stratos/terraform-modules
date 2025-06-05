module "cloudfront_logging" {
  source = "../cloudfront_logging"

  count = var.enable_logging ? 1 : 0

  log_bucket_arn                  = var.log_bucket_arn
  log_bucket_prefix_path          = var.log_bucket_prefix_path
  aws_cloudfront_distribution_arn = aws_cloudfront_distribution.this.arn
}
