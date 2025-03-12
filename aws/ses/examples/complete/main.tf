# SES default usage
module "ses" {
  source = "../../"

  email_domain = "example.com"

  emails = ["abc@example.com", "xyz@example.com"]

  principal_roles = ["*"]
}

# SES using route53 to verify email domain
module "ses_route53" {
  source = "../../"

  environment  = "dev"
  email_domain = "example1.com"

  emails = ["abc@example1.com", "xyz@example1.com"]

  principal_roles = ["arn:aws:iam::<account-id>:role/ses-role"]

  iam_role_ids = ["arn:aws:iam::<account-id>:role/ses-role"]

  verify_domain = true
  record_ttl    = 600
  record_type   = "TXT"

  enabled_outgoing_email_logs           = false
  datadog_api_key                       = null
  datadog_site                          = null
  enabled_datadog_dashboard             = true
  datadog_dashboard_default_environment = "dev"
}
