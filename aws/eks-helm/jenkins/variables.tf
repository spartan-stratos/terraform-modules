variable "chart_version" {
  description = "The Jenkins chart version"
  type        = string
  default     = "5.2.2"
}

variable "name" {
  type    = string
  default = "jenkins"
}

variable "domain" {
  description = "The root domain of project"
  type        = string
}

variable "github_org_display_name" {
  description = "The Github org display name"
  type        = string
  default     = "Spartan"
}

variable "github_credential_id" {
  description = "GitHub credentials key for jenkins"
  type        = string
}

variable "github_app_oauth_client_id" {
  description = "The Client ID of Spartan SSO"
  type        = string
  default     = ""
}

variable "github_app_oauth_client_secret" {
  description = "The Client Secret of Spartan SSO"
  type        = string
  sensitive   = true
  default     = ""
}

variable "jenkins_admins" {
  type        = list(string)
  default     = []
  description = "List of Jenkins admins"
}


variable "jenkins_executors" {
  type        = list(string)
  default     = []
  description = "List of Jenkins executors"
}

variable "jenkins_shared_lib_repo" {
  description = "The Jenkins shared library repo"
  type        = string
}

variable "namespace" {
  description = "Namespace to install Jenkins. Default is jenkins"
  type        = string
  default     = "jenkins"
}

variable "general_secrets" {
  description = "Secrets are shared across all repos"
  type        = map(string)
}

variable "jenkins_base_agent_image_repo" {
  description = "The base image for Jenkins agents"
  type        = string
}

variable "jenkins_base_agent_image_name" {
  description = "The base image for Jenkins agents"
  type        = string
}

variable "jenkins_base_agent_image_tag" {
  description = "The base image for Jenkins agents"
  type        = string
}

variable "slack_bot_token" {
  description = "The slack bot token"
  type        = string
  default     = null
}

variable "google_user_list" {
  description = "List users and roles for accessing Jenkins"
  type        = map(list(string))
  default     = null
}

variable "environment" {
  description = "The environment name"
  type        = string
}

variable "github_app_credential_id" {
  description = "GitHub App credentials key for jenkins"
  type        = string
  default     = "github-credentials"
}

variable "efs_id" {
  description = "EFS is for mounting Jenkins home"
  type        = string
}

variable "efs_jenkins_access_point" {
  description = "EFS is for mounting Jenkins home"
  type        = string
  default     = "/jenkins-home"
}

variable "efs_storage_class_name" {
  description = "EFS storage class of Jenkins volume"
  type        = string
  default     = "efs"
}

variable "github_org" {
  description = "The Github org name"
  type        = string
}

variable "jenkins_dns_name" {
  description = "The Jenkins DNS name"
  type        = string
  default     = "jenkins"
}

variable "jenkins_fqdn" {
  description = "FQDN of Jenkins service"
  type        = string
  default     = ""
}

variable "ingress_class_name" {
  description = "The ingress class name of Jenkins ingress"
  type        = string
  default     = "alb"
}

variable "ingress_group_name" {
  description = "The ingress group name of Jenkins ingress"
  type        = string
  default     = "external"
}

variable "shared_lib_name" {
  description = "The name Jenkins uses to name the shared library"
  type        = string
  default     = "spartan"
}

variable "jenkins_cpu" {
  description = "The CPU request and limit for Jenkins"
  type        = string
  default     = "1950m"
}

variable "jenkins_memory" {
  description = "The memory request and limit for Jenkins"
  type        = string
  default     = "4.5Gi"
}

variable "admin_alias" {
  description = "The alias of Jenkins admin"
  type        = string
  default     = "Spartan"
}

variable "enabled_datadog" {
  description = "Enable Datadog monitoring"
  type        = bool
  default     = true
}

variable "enabled_github_app_login" {
  description = "Enable Github App login, only one of Github App login or Google login can be enabled"
  type        = bool
  default     = false
}

variable "enabled_google_login" {
  description = "Enable Google login, only one of Github App login or Google login can be enabled"
  type        = bool
  default     = false

  validation {
    condition     = var.enabled_github_app_login && var.enabled_google_login
    error_message = "Only one of Github App login or Google login can be enabled"
  }
}

variable "google_oauth_client_id" {
  description = "The Client ID of Google SSO"
  type        = string
  default     = ""
}

variable "google_oauth_client_secret" {
  description = "The Client Secret of Google SSO"
  type        = string
  sensitive   = true
  default     = ""
}

variable "enabled_init_scripts" {
  description = "Enable init scripts"
  type        = bool
  default     = true
}

variable "enabled_slack_notification" {
  description = "Enable Slack notification"
  type        = bool
  default     = true
}

variable "install_plugins" {
  description = "List of Jenkins plugins to install"
  type        = list(string)
  default = [
    "configuration-as-code:1836.vccda_4a_122a_a_e",
    "git:5.2.2",
    "kubernetes:4246.v5a_12b_1fe120e",
    "workflow-aggregator:596.v8c21c963d92d"
  ]
}

variable "additional_plugins" {
  description = "List of additional Jenkins plugins to install"
  type        = list(string)
  default = [
    "ansicolor:1.0.4",
    "blueocean:1.27.13",
    "config-file-provider:973.vb_a_80ecb_9a_4d0",
    "credentials:1378.v81ef4269d764",
    "dark-theme:439.vdef09f81f85e",
    "extended-read-permission:53.v6499940139e5",
    "github:1.39.0",
    "github-oauth:597.ve0c3480fcb_d0",
    "google-login:109.v022b_cf87b_e5b_",
    "http_request:1.18",
    "job-dsl:1.87",
    "matrix-auth:3.2.2",
    "nodejs:1.6.1",
    "oidc-provider:62.vd67c19f76766",
    "pipeline-stage-view:2.34",
    "pipeline-utility-steps:2.16.2",
    "role-strategy:727.vd344b_eec783d",
    "slack:722.vd07f1ea_7ff40",
    "sonar:2.17.2",
    "sshd:3.330.vc866a_8389b_58",
    "theme-manager:262.vc57ee4a_eda_5d",
    "timestamper:1.27",
    "ws-cleanup:0.46"
  ]
}

variable "enabled_dark_them" {
  description = "Enable dark theme"
  type        = bool
  default     = false
}

variable "jenkins_env_var" {
  description = "Jenkins environment variables"
  type        = string
  default     = null
}

variable "kaniko_version" {
  description = "Version of Kaniko build tool"
  type        = string
  default     = "v1.21.1"
}
