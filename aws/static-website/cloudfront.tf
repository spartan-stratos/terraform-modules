module "cloudfront" {
  source              = "./modules/cloudfront"
  dns_name            = var.dns_name
  route53_zone_id     = var.route53_zone_id
  route53_zone_name   = var.route53_zone_name
  s3_bucket_id        = module.s3.s3_bucket_id
  ssl_certificate_arn = var.global_tls_certificate_arn
}
