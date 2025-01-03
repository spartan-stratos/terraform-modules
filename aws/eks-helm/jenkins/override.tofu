terraform {
  # Opentofu version constraint
  required_version = ">= 1.8.0"
}

# References in Variable Validation is not yet supported
# We need to wait for v1.9.0 to release https://github.com/opentofu/opentofu/pull/2216
variable "enabled_google_login" {
  description = "Enable Google login, only one of Github App login or Google login can be enabled"
  type        = bool
  default     = false

  # validation {
  #   condition     = !(var.enabled_github_app_login && var.enabled_google_login)
  #   error_message = "Only one of Github App login or Google login can be enabled"
  # }
}
