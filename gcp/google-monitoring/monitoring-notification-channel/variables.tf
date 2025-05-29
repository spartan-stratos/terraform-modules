variable "display_name" {
  description = "A short label describing the notification channel, such as 'Production Pager'."
  type        = string
}

variable "type" {
  description = "The type of the notification channel. Supported values include: 'email', 'sms', 'slack', 'webhook', etc. (see GCP docs for full list)."
  type        = string
}

variable "labels" {
  description = "Configuration fields that define the channel behavior. The `email_address` key is required for type 'email', for example."
  type        = map(string)
}

variable "auth_token" {
  description = "An authorization token for a notification channel. Channel types that support this field include: slack."
  type        = string
  default     = null
}

variable "password" {
  description = "An password for a notification channel. Channel types that support this field include : webhook_basicauth."
  type        = string
  default     = null
}

variable "service_key" {
  description = "An service key token for a notification channel. Channel types that support this field include : pagerduty."
  type        = string
  default     = null
}
