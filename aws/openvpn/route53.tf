locals {
  default_fqdn = "${var.vpn_name}.${var.domain_name}"
  openvpn_fqdn = var.openvpn_fqdn != "" ? var.openvpn_fqdn : local.default_fqdn
}

data "aws_route53_zone" "domain" {
  name = var.domain_name
}

resource "aws_route53_record" "vpn" {
  zone_id = data.aws_route53_zone.domain.zone_id

  name = local.openvpn_fqdn
  type = "A"
  ttl  = "60"

  records = [aws_eip.this.public_ip]
}
