module "cloudfront" {
  source = "./modules/cloudfront"

  dns_name                        = var.dns_name
  domain_name                     = var.domain_name
  route53_zone_id                 = var.route53_zone_id
  s3_bucket_id                    = var.enabled_create_s3 ? module.s3[0].s3_bucket_id : data.aws_s3_bucket.this[0].id
  ssl_certificate_arn             = var.global_tls_certificate_arn
  viewer_protocol_policy          = var.viewer_protocol_policy
  minimum_protocol_version        = var.minimum_protocol_version
  price_class                     = var.price_class
  use_www_domain                  = var.use_www_domain
  cloudfront_distribution_aliases = var.cloudfront_distribution_aliases
}
