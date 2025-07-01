/**
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel
 */
resource "google_monitoring_notification_channel" "this" {
  display_name = var.display_name
  type         = var.type
  labels       = var.labels
  sensitive_labels {
    auth_token  = var.auth_token
    password    = var.password
    service_key = var.service_key
  }
}
