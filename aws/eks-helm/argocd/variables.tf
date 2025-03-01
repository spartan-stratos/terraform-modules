variable "namespace" {
  description = "Namespace to install Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Version of the Argo CD Helm chart"
  type        = string
  default     = "7.8.2" # Adjust as needed
}

variable "github_org" {
  description = "GitHub organization to watch"
  type        = string
}

variable "listRepoURL" {
  description = "List Repository URL need to be sync"
  type = list(object({
    service_name   = string
    repoURL        = string
    path           = string
    targetRevision = optional(string, "v*.*.*")
    value_files    = optional(list(string), ["values.yaml"])
    namespace      = string
  }))
}

variable "slack_token" {
  description = "Slack Token to notify"
  type        = string
  default     = null
}
