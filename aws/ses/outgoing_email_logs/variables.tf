variable "name" {
  description = "The name of the outgoing logs"
  type        = string
}

variable "environment" {
  description = "The environment of the outgoing logs"
  type        = string
}

variable "ses_identity_ids" {
  description = "The list of the SES outgoing identities"
  type        = list(string)
}

variable "datadog_api_key" {
  description = "The datadog api key"
  type        = string
  sensitive   = true
}

variable "datadog_site" {
  description = "The datadog site"
  type        = string
  default     = "datadoghq.com"
}

variable "enabled_outgoing_email_logs_cloudwatch" {
  description = "Whether to enable the SES outgoing email logs on CloudWatch."
  type        = bool
  default     = false
}

variable "enabled_datadog_dashboard" {
  description = "Whether to enable the Datadog dashboard."
  type        = bool
  default     = false
}
