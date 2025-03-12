variable "environment" {
  description = "Environment name to be used on the resource group name construction."
  type        = string
  default     = null
}

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

variable "verify_domain" {
  description = "To enable route53 record to verify email domain"
  type        = bool
  default     = false
}

variable "publish_mx_record" {
  description = "Publish an MX record for Amazon SES email receiving."
  type        = bool
  default     = false
}

variable "publish_dkim_record" {
  description = "Publish the DKIM (DomainKeys Identified Mail) records signing for outgoing emails."
  type        = bool
  default     = false
}

variable "email_receiving_endpoint" {
  description = "The SMTP endpoint used for receiving emails. This is typically the inbound email receiving endpoint for Amazon SES in the specified region, such as 'inbound-smtp.us-west-2.amazonaws.com'. Update this if using a custom or alternative email receiving service."
  type        = string
  default     = "inbound-smtp.us-west-2.amazonaws.com"
}

variable "enabled_ses_identity_policy" {
  description = "Whether to enable the SES identity policy."
  type        = bool
  default     = true
}

variable "enabled_outgoing_email_logs" {
  description = "Whether to enable the SES outgoing email logs."
  type        = bool
  default     = false
}

variable "enabled_outgoing_email_logs_cloudwatch" {
  description = "Whether to enable the SES outgoing email logs on CloudWatch."
  type        = bool
  default     = false
}

variable "datadog_api_key" {
  description = "The datadog api key"
  type        = string
  sensitive   = true
  default     = null
}

variable "datadog_site" {
  description = "The datadog site"
  type        = string
  default     = "datadoghq.com"
}

variable "enabled_datadog_dashboard" {
  description = "Whether to enable the Datadog dashboard."
  type        = bool
  default     = false
}

variable "datadog_dashboard_environments" {
  description = "The environments to enable the Datadog dashboard for."
  type        = list(string)
  default     = ["dev", "prod"]
}

variable "datadog_dashboard_default_environment" {
  description = "The default environments to enable the Datadog dashboard for."
  type        = string
  default     = "prod"
}
