data "google_client_config" "this" {}

resource "google_compute_global_address" "this" {
  project      = data.google_client_config.this.project
  name         = "${var.prefix_name}-lb-ip-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_backend_bucket" "this" {
  provider = google
  project  = data.google_client_config.this.project

  name        = "${var.prefix_name}-bucket"
  bucket_name = var.bucket_name
  enable_cdn  = var.enable_cdn
}

resource "google_compute_url_map" "bucket" {
  provider = google
  project  = data.google_client_config.this.project

  name        = "${var.prefix_name}-lb"
  description = "URL map for ${var.prefix_name}"

  default_service = google_compute_backend_bucket.this.self_link
}

resource "google_compute_target_http_proxy" "http" {
  count   = var.enable_http ? 1 : 0
  project = data.google_client_config.this.project
  name    = "${var.prefix_name}-http-proxy"
  url_map = google_compute_url_map.bucket.id
}

resource "google_compute_global_forwarding_rule" "http" {
  count                 = var.enable_http ? 1 : 0
  provider              = google
  project               = data.google_client_config.this.project
  name                  = "${var.prefix_name}-http-rule"
  target                = google_compute_target_http_proxy.http[0].self_link
  ip_address            = google_compute_global_address.this.address
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}

resource "google_compute_managed_ssl_certificate" "this" {
  count = var.enable_ssl ? 1 : 0

  name = "${var.prefix_name}-ssl"
  managed {
    domains = ["${var.domain_name}"]
  }
}

resource "google_compute_target_https_proxy" "https" {
  count   = var.enable_ssl ? 1 : 0
  project = data.google_client_config.this.project
  name    = "${var.prefix_name}-https-proxy"
  url_map = google_compute_url_map.bucket.id

  certificate_map = var.certificate_map
}

resource "google_compute_global_forwarding_rule" "https" {
  count                 = var.enable_ssl ? 1 : 0
  provider              = google
  project               = data.google_client_config.this.project
  name                  = "${var.prefix_name}-https-rule"
  target                = google_compute_target_https_proxy.https[0].self_link
  ip_address            = google_compute_global_address.this.address
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}
