# Provider

variable "additional_thumbprints" {
  description = "List of additional thumbprints to add to the thumbprint list. Reference: https://plugins.jenkins.io/oidc-provider/."
  type        = list(string)
  default     = []
}

variable "client_id_list" {
  description = "List of client IDs (also known as audiences) for the IAM OIDC provider. Defaults to STS service if not values are provided."
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}

variable "url" {
  description = "The URL of the identity provider. Corresponds to the iss claim."
  type        = string
}

# Jenkins

variable "role_name" {
  description = "The name of the role to be created."
  type        = string
}

variable "role_name_prefix" {
  description = "The name of the role to be created."
  type        = string
  default     = ""
}

# Migration

variable "create_provider" {
  description = "Whether to create a provider resource for migration purpose on existing provider."
  type        = bool
  default     = false
}
