locals {
  build_spec  = var.enable_backend ? "${path.module}/build_spec_with_backend.tftpl" : "${path.module}/build_spec_frontend_only.tftpl"
  domain_name = var.sub_domain == "" ? var.dns_zone : "${var.sub_domain}.${var.dns_zone}"
}