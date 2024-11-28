module "cloudfront" {
  source = "./modules/cloudfront"

  dns_name               = var.dns_name
  route53_zone_id        = var.route53_zone_id
  route53_zone_name      = var.route53_zone_name
  s3_bucket_id           = var.enabled_create_s3 ? module.s3[0].s3_bucket_id : data.aws_s3_bucket.this[0].id
  ssl_certificate_arn    = var.global_tls_certificate_arn
  viewer_protocol_policy = var.viewer_protocol_policy
}
