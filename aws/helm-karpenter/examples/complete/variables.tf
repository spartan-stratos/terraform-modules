variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster API endpoint URL"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "Base64-encoded cluster CA certificate"
  type        = string
}

variable "oidc_provider_arn" {
  description = "EKS OIDC provider ARN"
  type        = string
}

variable "oidc_provider_url" {
  description = "EKS OIDC provider URL (without https://)"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for Karpenter-provisioned nodes"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs for Karpenter-provisioned nodes"
  type        = list(string)
}

variable "enable_karpenter_resources" {
  description = "Set to true after the initial helm_release apply to enable NodePool/EC2NodeClass creation"
  type        = bool
  default     = false
}
