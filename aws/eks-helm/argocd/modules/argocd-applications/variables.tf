variable "argocd_namespace" {
  description = "Namespace to install Argo CD"
  type        = string
  default     = "argocd"
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