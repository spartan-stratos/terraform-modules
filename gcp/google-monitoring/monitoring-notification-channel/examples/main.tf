module "email_notification_channel" {
  source = "../../"

  display_name = "Admin Email Notification"
  type         = "email"
  labels = {
    email_address = "admin@example.com"
  }
}

module "slack_notification_channel" {
  source = "../../"

  display_name = "Slack Notification"
  type         = "slack"
  labels = {
    "channel_name" = "#foobar"
  }
  auth_token = "one"
}
