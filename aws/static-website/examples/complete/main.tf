module "static_website" {
  source = "../../static-website"

  name        = "example"
  domain_name = "example.com"

  enabled_create_s3 = false
  dns_name          = "example"
  route53_zone_id   = "<r53_zone_id>"
  # route53_zone_name      = "spartan-dev.io"
  viewer_protocol_policy = "allow-all"

  global_tls_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-efgh-5678-ijkl-9012mnopqrst"

  ordered_cache_behaviors = [{
    path_pattern           = "/index.html"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "s3_origin_id"
    query_string           = false
    cookies_forward        = "none"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
  }]
}

