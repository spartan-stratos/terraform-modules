data "google_client_config" "this" {}

resource "google_recaptcha_enterprise_key" "android" {
  display_name = "${data.google_client_config.this.project}-${var.environment}-android-recaptcha"

  android_settings {
    allow_all_package_names = var.allow_all_package_names
    allowed_package_names   = var.allowed_package_names
  }

  project = data.google_client_config.this.project

  labels = {
    environment = var.environment
  }
}

resource "google_recaptcha_enterprise_key" "ios" {
  display_name = "${data.google_client_config.this.project}-${var.environment}-ios-recaptcha"

  ios_settings {
    allow_all_bundle_ids = var.allow_all_bundle_ids
    allowed_bundle_ids   = var.allowed_bundle_ids
  }

  project = data.google_client_config.this.project

  labels = {
    environment = var.environment
  }
}
