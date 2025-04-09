variable "namespace" {
  description = "The Namespace of the services."
  type        = string
  default     = "kube-system"
}

variable "helm_release_name" {
  description = "The Helm release of the services."
  type        = string
  default     = "ingress-nginx"
}

variable "replicas" {
  description = "Number of pods."
  type        = number
  default     = 1
}

variable "minReplicas" {
  description = "Min numer of pods."
  type        = number
  default     = 1
}

variable "maxReplicas" {
  description = "Max number of pods."
  type        = number
  default     = 3
}

variable "nginx_cpu" {
  description = "The nginx cpu"
  type        = string
  default     = "100m"
}

variable "nginx_memory" {
  description = "The nginx memory"
  type        = string
  default     = "90Mi"
}

variable "helm_chart_version" {
  default     = "4.12.1"
  type        = string
  description = "The chart version of ingress controller"
}

variable "network_cidr" {
  type        = string
  description = "Internal network CIDR for forwarding real IPs through Nginx"
}

variable "enabled_admission_webhooks" {
  type        = bool
  description = "Enable admission webhooks"
  default     = false
}

variable "ingress_group_name" {
  description = "The ingress group name of Neo4j ingress"
  type        = string
  default     = "external"
}

variable "ingress_class_name" {
  description = "The ingress class name of Neo4j ingress"
  type        = string
  default     = "alb"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Determines whether a new namespace should be created. Set to 'true' to create the namespace; otherwise, set to 'false' to use an existing namespace."
}
