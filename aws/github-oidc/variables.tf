variable "role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "role_name" {
  description = "The name of the role to be created."
  type        = string
}

variable "role_name_prefix" {
  description = "The name of the role to be created."
  type        = string
  default     = ""
}

variable "repository_path" {
  description = "The path to the repository (organization/repo_name)."
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account id to assume role."
  type        = string
}

variable "conditions" {
  description = "(Optional) Additonal conditions for checking the OIDC claim."
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  default = []
}
