module "static_website" {
  source = "../../"

  name = "example"
  domain_name = "example.com"

  enabled_create_s3      = false
  dns_name               = "example"
  route53_zone_id        = "<r53_zone_id>"
  # route53_zone_name      = "spartan-dev.io"
  viewer_protocol_policy = "allow-all"

  global_tls_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-efgh-5678-ijkl-9012mnopqrst"
}

