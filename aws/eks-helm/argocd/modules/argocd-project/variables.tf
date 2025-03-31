variable "project_name" {
  description = "Name of the Argo CD project"
  type        = string
}

variable "argocd_namespace" {
  description = "Namespace of Argo CD"
  type        = string
  default     = "argocd"
}

variable "description" {
  description = "Description of the Argo CD project"
  type        = string
}

variable "restrict_source_repos" {
  description = "Applicable source repositories"
  type        = list(string)
  default     = ["*"]
}

variable "restrict_destinations" {
  description = "Applicable destinations"
  type = list(object({
    server    = string
    namespace = string
  }))

  default = [
    {
      server    = "*"
      namespace = "*"
    }
  ]
}

variable "github_organization" {
  description = "GitHub organization"
  type        = string
}

variable "github_repositories" {
  description = "GitHub repositories"
  type        = set(string)
}

variable "enabled_custom_github_app" {
  description = "Enable custom GitHub App configuration"
  type        = bool
  default     = false
}

variable "argo_app_installation_id" {
  description = "Installation ID of the Argo CD GitHub App"
  type        = number
  default     = null
}

variable "github_app" {
  description = "GitHub App configuration to use for Argo CD, only required if enabled_custom_github_app is true"
  type = object({
    id              = number
    installation_id = number
    private_key     = string
  })
  sensitive = true

  # Only required if enabled_custom_github_app is true
  default = null
}

variable "project_group_roles" {
  description = "Roles for the project, only required if custom_project_group_roles is true"
  type        = map(list(string))
  default = {
    "argo-admin" = [
      "applications, *, *, allow",
      "applicationsets, *, *, allow",
    ]

    "argo-member" = [
      "applications, get, *, allow",
      "applicationsets, get, *, allow",
    ]
  }
}
