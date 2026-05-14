variable "name" {
  description = "NodePool name"
  type        = string
}

variable "requirements" {
  description = "List of node requirements (architecture, instance family, size, etc.)"
  type = list(object({
    key      = string
    operator = string
    values   = list(string)
  }))
}

variable "ec2_node_class_name" {
  description = "Name of the EC2NodeClass to reference"
  type        = string
}

variable "cpu_limit" {
  description = "Maximum CPU across all nodes in this pool"
  type        = string
}

variable "memory_limit" {
  description = "Maximum memory across all nodes in this pool"
  type        = string
}

variable "consolidation_policy" {
  description = "Consolidation policy (WhenEmpty, WhenEmptyOrUnderutilized)"
  type        = string
}

variable "consolidate_after" {
  description = "Time to wait before consolidating nodes"
  type        = string
}

variable "expire_after" {
  description = "Time before nodes expire and are replaced"
  type        = string
}

variable "labels" {
  description = "Kubernetes labels to apply to nodes"
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "Kubernetes taints to apply to nodes"
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}

variable "depends_on_resources" {
  description = "Resources this module depends on (to control creation order)"
  type        = any
  default     = []
}
