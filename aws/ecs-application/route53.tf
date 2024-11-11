/*
aws_route53_record provides a Route53 record resource for ALB of the ECS service.
*/
resource "aws_route53_record" "main" {
  name    = var.dns_name
  zone_id = var.route53_zone_id
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
