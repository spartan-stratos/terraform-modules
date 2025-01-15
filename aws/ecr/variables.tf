variable "name" {
  description = "Name of the ECR"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "custom_ecr_scanning" {
  description = "Enable custom ECR scanning"
  type        = bool
  default     = false
}

variable "scan_type" {
  description = "The type of scan to run. Valid values: 'BASIC', 'ENHANCED'"
  type        = string
  default     = "BASIC"
}

variable "scan_frequency" {
  description = "The frequency of the scan. Valid values: 'CONTINUOUS_SCAN', 'SCAN_ON_PUSH', 'MANUAL'"
  type        = string
  default     = "SCAN_ON_PUSH"
}
