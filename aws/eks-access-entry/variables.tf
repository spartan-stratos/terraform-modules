variable "aws_account_id" {
  description = "The AWS account ID to which the IAM SSO group will be assigned."
  type        = string
}

variable "custom_namespaces" {
  type        = list(string)
  description = "Custom namespaces to be created during initialization"
  default     = []
}

variable "access_entries" {
  description = "List of access entries for EKS access entries and policies"
  type = map(object({
    principal_name    = string
    kubernetes_groups = optional(list(string))
    type              = optional(string)
    policy_arn        = optional(string)
    namespaces        = optional(list(string))
    trusted_role_arn  = optional(list(string))
    access_type       = optional(string, "cluster")
  }))
  default = {}
}

variable "iam_path" {
  description = "If provided, all IAM roles will be created on this path."
  type        = string
  default     = "/"
}

variable "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}
