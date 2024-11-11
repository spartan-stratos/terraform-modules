resource "aws_route53_record" "this" {
  name    = var.dns_name
  zone_id = var.route53_zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = true
  }
}
