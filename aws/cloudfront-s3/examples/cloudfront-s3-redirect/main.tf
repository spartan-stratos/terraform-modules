module "cloudfront-s3" {
  source = "../../"

  # CloudFront config properties
  domain_name         = "<Sub domain name for route53 record>"
  route53_zone_id     = "<Route 53 id>"
  ssl_certificate_arn = "<ACM certificate arn>"

  ordered_cache_behaviors = [{
    path_pattern           = "/index.html"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "<target-origin-id>"
    query_string           = false
    cookies_forward        = "none"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
  }]

  # S3 config properties
  s3_bucket_id       = "<bucket id>"
  s3_redirect_domain = "<S3 bucket domain to direct>"
}
