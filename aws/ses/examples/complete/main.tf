module "ses" {
  source            = "../../"

  email_domain = "example.com"

  emails = ["example1.com", "example2.com"]
  
  principal_roles   = ["arn:aws:iam::<account-id>:role/ses-role"]
}
