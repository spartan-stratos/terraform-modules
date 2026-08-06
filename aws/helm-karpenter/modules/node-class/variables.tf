variable "name" {
  description = "EC2NodeClass name"
  type        = string
}

variable "ami_family" {
  description = "AMI family (AL2023, AL2, Bottlerocket, Ubuntu, etc.)"
  type        = string
}

variable "ami_alias" {
  description = "AMI alias selector (e.g., al2023@latest)"
  type        = string
}

variable "node_iam_role_name" {
  description = "IAM role name for Karpenter-provisioned nodes. Karpenter's EC2NodeClass uses spec.role (the role name, not the instance profile name) and the controller auto-manages the instance profile via iam:CreateInstanceProfile."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for node placement"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for nodes"
  type        = list(string)
}

variable "volume_size" {
  description = "EBS volume size (e.g., 100Gi)"
  type        = string
}

variable "volume_type" {
  description = "EBS volume type (gp3, gp2, io1, etc.)"
  type        = string
}

variable "volume_iops" {
  description = "EBS volume IOPS (for gp3: 3000-16000, io1/io2: 100-64000). Default 3000 for gp3. Higher IOPS significantly increase costs."
  type        = number
  default     = 3000

  validation {
    condition     = var.volume_iops >= 3000 && var.volume_iops <= 16000
    error_message = "EBS IOPS for gp3 must be between 3000-16000. Each 1000 IOPS above 3000 adds ~$0.065/GB/month."
  }
}

variable "volume_throughput" {
  description = "EBS volume throughput in MB/s (for gp3: 125-1000). Default 125 MB/s. Higher throughput increases costs."
  type        = number
  default     = 125

  validation {
    condition     = var.volume_throughput >= 125 && var.volume_throughput <= 1000
    error_message = "EBS throughput for gp3 must be between 125-1000 MB/s. Each 1 MB/s above 125 adds ~$0.04/GB/month."
  }
}

variable "imds_hop_limit" {
  description = "IMDS hop limit - must be >= 2 for containerized workloads with IRSA to access instance metadata"
  type        = number
  default     = 2

  validation {
    condition     = var.imds_hop_limit >= 2
    error_message = "IMDS hop limit must be >= 2 for pods to access instance metadata via IRSA. Default of 1 only works for processes running directly on the host."
  }
}

variable "depends_on_resources" {
  description = "Resources this module depends on (to control creation order)"
  type        = any
  default     = []
}
