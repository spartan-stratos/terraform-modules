locals {
  notification_rules = {
    prod_slack_rule = {
      name       = "Prod Slack Notification Rule"
      recipients = ["slack-prj-x-prod"]
      filter = {
        tags = ["env:prod"]
      }
    }
  }
}

module "datadog_notification_rules" {
  source = "c0x12c/notification-rules/datadog"

  notification_rules = local.notification_rules
}