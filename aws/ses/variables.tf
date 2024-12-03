variable "email_domain" {
  type        = string
  description = "The domain name for which SES will be configured (e.g., 'example.com')."
}

variable "emails" {
  type        = list(string)
  default     = []
  description = "List of email addresses allowed for sending in SES sandbox mode. These are verified to send emails during testing."
}

variable "principal_roles" {
  type        = list(string)
  default     = []
  description = "List of IAM roles that should have access to SES. These roles will have permissions to manage and use SES for the configured domain."
}
