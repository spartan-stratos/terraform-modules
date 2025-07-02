module "email_notification_channel" {
  source = "../../monitoring-notification-channel"

  display_name = "Admin Email Notification"
  type         = "email"
  labels = {
    email_address = "admin@example.com"
  }
}

module "slack_notification_channel" {
  source = "../../monitoring-notification-channel"

  display_name = "Slack Notification"
  type         = "slack"
  labels = {
    "channel_name" = "#foobar"
  }
  auth_token = "one"
}
