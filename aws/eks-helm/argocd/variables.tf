variable "argocd_namespace" {
  description = "Namespace to install Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Version of the Argo CD Helm chart"
  type        = string
  default     = "7.8.14"
}

variable "chart_url" {
  description = "URL of the Argo CD Helm chart"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "enabled_custom_ingress" {
  description = "To enable alb ingress and use aws load balancer controller to manage"
  type        = bool
  default     = false
}

variable "ingress" {
  description = "Ingress configuration for Argo CD"
  type = object({
    enabled       = bool
    ingress_class = optional(string, "")
    controller    = optional(string, "generic")
    annotations   = optional(map(string), {})
    path          = optional(string, "/")
    pathType      = optional(string, "Prefix")
  })
  default = {
    enabled = false
  }
}

variable "handle_tls" {
  description = "If ArgoCD should handle TLS itself"
  type        = bool
  default     = false
}

variable "server_side_diff" {
  description = "Enable server side diff"
  type        = bool
  default     = true
}

variable "enabled_aws_management_role" {
  description = "Enable the AWS management role for cross cluster management"
  type        = bool
  default     = false
}

variable "aws_management_role" {
  description = "AWS management role configuration, only required if enabled_aws_management_role is true"
  type = object({
    eks_oidc_provider_arn = string
    role_name             = string
  })

  # Only required if enabled_aws_management_role is true
  default = null
}

variable "github_app" {
  description = "GitHub App configuration to use for Argo CD"
  type = object({
    app_name     = string
    id           = number
    private_key  = string
    organization = string
  })
  sensitive = true
}

variable "oidc_github_client_id" {
  description = "GitHub App Client ID for OIDC"
  type        = string
}

variable "oidc_github_client_secret" {
  description = "GitHub App Client Secret for OIDC"
  type        = string
  sensitive   = true
}

variable "oidc_github_organization" {
  description = "GitHub organization to restrict access to"
  type        = string
}

variable "rbac_policies" {
  description = "List of RBAC policies to apply"
  type        = list(string)
  default     = []
}

variable "external_clusters" {
  description = "Maps of external cluster that want to connect"
  type = map(object({
    assumeRole       = string
    server           = string
    labels           = optional(map(any), {})
    annotations      = optional(map(any), {})
    namespace        = optional(string, "")
    clusterResources = optional(bool, false)
    config           = map(any)
  }))
  default = {}
}

variable "applications" {
  description = "Maps of application configuration which will point to, each application will represent for a service on a envinronment"
  type = map(object({
    name                     = string
    environment              = string
    project_name             = string
    destination_cluster_name = string
    namespace                = string
    repo_url                 = string
  }))
  default = {}
}

# Slack
variable "slack_channel" {

}

variable "slack_token" {
  description = "The token to authenticate to slack, which will help application push notification to slack"
  type        = string
  default     = ""
  sensitive   = true
}

variable "domain_name" {
  description = "Domain name for ArgoCD"
  type        = string
}

# Repo Connection

variable "argocd_projects" {
  description = "A map defining ArgoCD projects with their configurations."
  type = map(object({
    project_name               = string       # The name of the ArgoCD project, used to uniquely identify it.
    description                = string       # A brief description of the project, providing context or purpose.
    github_organization        = string       # The GitHub organization name associated with the project.
    github_repositories        = list(string) # A list of GitHub repository names managed by the project.
    argocd_app_installation_id = number       # The unique numeric ID for the ArgoCD application installation.
  }))
}
variable "project_group_roles" {
  description = "The project groups roles will have the following format: 'applications, {roles}, {target-project}, allow'. Example: \"spartan-iaas-p0001\" =  \"applications, *, *, allow\""
  type        = map(list(string))
  default = {
    "argo-admin" = [
      "applications, *, *, allow",
    ]

    "argo-member" = [
      "applications, get, *, allow",
    ]
  }
}

# Sync policy
variable "sync_policy" {
  description = "value"
  type = object({
    automated = object({
      prune    = bool
      selfHeal = bool
    })

    syncOptions = list(string)

    retry = object({
      limit = number
    })
  })
  default = {
    automated = {
      prune    = true
      selfHeal = true
    }

    syncOptions = [
      "CreateNamespace=true",
      "Retry=true",
    ]

    retry = {
      limit = 5
    }
  }


}