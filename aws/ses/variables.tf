variable "email_domain" {
  description = "The domain name for which SES will be configured (e.g., 'example.com')."
  type        = string
}

variable "emails" {
  description = "List of email addresses allowed for sending in SES sandbox mode. These are verified to send emails during testing."
  type        = list(string)
  default     = []
}

variable "principal_roles" {
  description = "List of IAM principal roles that should have access to SES."
  type        = list(string)
  default     = null
}

variable "iam_role_ids" {
  type        = list(string)
  default     = []
  description = "List of IAM role ids that should have access to SES. These roles will have permissions to send SES email."
}


variable "record_type" {
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT."
  type        = string
  default     = "TXT"
}

variable "record_ttl" {
  description = "The TTL of the record."
  type        = number
  default     = 600
}

variable "use_route53" {
  description = "To enable route53 record to verify email domain"
  type        = bool
  default     = false
}
