variable "email_domain" {
  description = "The domain name for which SES will be configured (e.g., 'example.com')."
  type        = string
}

variable "emails" {
  description = "List of email addresses allowed for sending in SES sandbox mode. These are verified to send emails during testing."
  type        = list(string).0
  default     = []
}

variable "principal_roles" {
  description = "List of IAM roles that should have access to SES. These roles will have permissions to manage and use SES for the configured domain."
  type        = list(string)
  default     = []
}
