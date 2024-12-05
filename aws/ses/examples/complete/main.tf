# SES default usage
module "ses" {
  source = "../../"

  email_domain = "example.com"

  emails = ["abc@example.com", "xyz@example.com"]

  principal_roles = ["arn:aws:iam::<account-id>:role/ses-role"]
}

# SES using route53 to verify email domain
module "ses" {
  source = "../../"

  email_domain = "example1.com"

  emails = ["abc@example1.com", "xyz@example1.com"]

  principal_roles = ["arn:aws:iam::<account-id>:role/ses-role"]

  use_route53 = true
  record_ttl  = 600
  record_type = "TXT"
}
