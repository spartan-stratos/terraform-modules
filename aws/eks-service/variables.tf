variable "cluster_name" {
  type        = string
  description = "EKS Cluster name"
}

variable "service" {
  description = "Mapping of service name, namespace and their secrets"
  type = object({
    name                       = string
    additional_iam_policy_arns = optional(list(string), [])
    config_map                 = optional(map(any), {})
    hostnames                  = list(string)
    namespace                  = string
    secrets                    = optional(map(any), {})
  })
}

variable "route53_zone_id" {
  type        = string
  description = "The zone id for adding hostnames for services"
}

variable "alb_dns" {
  type        = string
  description = "The DNS of the ALB from K8s cluster"
}

variable "region" {
  type        = string
  description = "Region for getting ALB hosted zone ID"
}

variable "eks_oidc_provider" {
  description = "The OIDC provider of the EKS cluster"
  type = object({
    arn = string
    url = string
  })
}

variable "suffix_service_name" {
  description = "To custom name suffix for the kubernetes secret"
  type        = string
  default     = "env-var"
}

variable "create_kubernetes_namespace" {
  description = "To specify whether to create a namespace"
  type        = bool
  default     = false
}
