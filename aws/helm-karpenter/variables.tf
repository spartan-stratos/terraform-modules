# Karpenter Module Variables

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

# EKS Cluster Configuration
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint URL"
  type        = string
}

variable "oidc_provider_arn" {
  description = "EKS OIDC provider ARN for IRSA"
  type        = string
}

variable "oidc_provider_url" {
  description = "EKS OIDC provider URL (without https://)"
  type        = string
}

# Network Configuration
variable "subnet_ids" {
  description = "List of subnet IDs for Karpenter-provisioned nodes"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for Karpenter-provisioned nodes"
  type        = list(string)
}

# Feature Flags
variable "enable_node_pools" {
  description = "Enable NodePool and EC2NodeClass resource creation. Set to false on first apply to let Karpenter CRDs install before NodePool manifests are created."
  type        = bool
  default     = true
}

# Helm Configuration
variable "karpenter_version" {
  description = "Karpenter Helm chart version"
  type        = string
  default     = "1.12.0"
}

variable "karpenter_namespace" {
  description = "Kubernetes namespace for Karpenter"
  type        = string
  default     = "karpenter"
}

variable "karpenter_replicas" {
  description = "Number of Karpenter controller replicas"
  type        = number
  default     = 1
}

# NodePool Configuration
variable "node_pools" {
  description = <<-EOT
    Map of NodePool configurations. Each pool can use a preset or custom configuration.

    Preset-based example:
      node_pools = {
        builder = { preset = "builder" }
        apps    = { preset = "general-purpose", cpu_limit = "128" }
      }

    Custom configuration example:
      node_pools = {
        custom = {
          instance_families = ["m5", "m6i"]
          instance_sizes    = ["xlarge", "2xlarge"]
          architectures     = ["amd64"]
          capacity_types    = ["spot"]
          cpu_limit         = "32"
          memory_limit      = "128Gi"
          # ... other fields
        }
      }

    Available presets: builder, general-purpose, compute-optimized, memory-optimized
  EOT
  type        = map(any)
  default     = {}
}

# IAM Configuration
variable "additional_node_policies" {
  description = "Additional IAM policy ARNs to attach to Karpenter node role"
  type        = list(string)
  default     = []
}

# EC2NodeClass Configuration
variable "ami_family" {
  description = "AMI family for Karpenter nodes"
  type        = string
  default     = "AL2023"
}

variable "ami_alias" {
  description = "AMI alias selector (e.g., al2023@latest)"
  type        = string
  default     = "al2023@latest"
}

variable "imds_hop_limit" {
  description = "IMDS hop limit - must be >= 2 for containerized workloads with IRSA"
  type        = number
  default     = 2

  validation {
    condition     = var.imds_hop_limit >= 2
    error_message = "IMDS hop limit must be >= 2 for pods to access instance metadata via IRSA"
  }
}

# Karpenter NodePool Configuration
variable "tolerations" {
  description = "Tolerations for Karpenter"
  type = list(object({
    key      = string
    operator = string
    value    = optional(string)
    effect   = optional(string)
  }))
  default = []
}

variable "node_selector" {
  description = "Node selector for Karpenter"
  type        = map(string)
  default     = {}
}
