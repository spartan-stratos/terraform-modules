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

variable "github_repositories" {
  description = "GitHub repositories"
  type        = set(string)
}

variable "enabled_custom_github_app" {
  description = "Enable custom GitHub App configuration"
  type        = bool
  default     = false
}

variable "github_app" {
  description = "GitHub App configuration to use for Argo CD"
  type = object({
    name            = string
    app_id          = number
    installation_id = number
    private_key     = string
    organization    = string
  })
  sensitive = true
}

variable "group_roles" {
  description = <<EOT
The project group roles define permissions in the format: 'applications, {roles}, {target-project}, allow'.
- 'applications' specifies the scope (e.g., 'applications' or a specific app).
- '{roles}' can be specific roles (e.g., 'admin', 'viewer') or '*' for all roles.
- '{target-project}' specifies the target project (e.g., 'spartan-iaas-p0001') or '*' for all projects.
- 'allow' indicates the permission type (currently only 'allow' is supported).

Example:
  "spartan-P00001-iaas" = ["applications, *, *, allow",]
  "spartan-P00001-member"  = [
      "applications, *, spartan-eks-dev/*, allow"
      "applications, get, *, allow"
    ]
EOT
  type        = map(list(string))
  default     = {}
}
