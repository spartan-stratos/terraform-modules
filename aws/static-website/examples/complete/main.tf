module "static_website" {
  source = "../../"

  name        = "example"
  stack_name  = "spartan"
  environment = "dev"

  dns_name          = "example"
  route53_zone_id   = "<r53_zone_id>"
  route53_zone_name = "spartan-dev.io"

  global_tls_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-efgh-5678-ijkl-9012mnopqrst"
}

