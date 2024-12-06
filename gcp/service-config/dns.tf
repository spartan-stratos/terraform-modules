/**
This block will create only 1 DNS records.
 */
module "dns" {
  source = "../cloud-dns"

  count = var.managed_zone != null ? 1 : 0

  dns_name   = "${var.managed_zone}."
  dns_zone   = var.managed_zone
  create_new = var.create_dns_zone

  custom_records = {
    "${var.name}" = {
      ttl     = var.dns_ttl
      type    = "A"
      rrdatas = var.dns_rrdatas
    }
  }
}
