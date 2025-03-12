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

  validation {
    condition     = contains(["BASIC", "ENHANCED"], var.scan_type)
    error_message = "Invalid scan type. Must be 'BASIC' or 'ENHANCED'"
  }
}

variable "scan_frequency" {
  description = "The frequency of the scan. Valid values: 'CONTINUOUS_SCAN', 'SCAN_ON_PUSH', 'MANUAL'"
  type        = string
  default     = "SCAN_ON_PUSH"

  validation {
    condition     = contains(["CONTINUOUS_SCAN", "SCAN_ON_PUSH", "MANUAL"], var.scan_frequency)
    error_message = "Invalid scan frequency. Must be 'CONTINUOUS_SCAN', 'SCAN_ON_PUSH', or 'MANUAL'"
  }
}

variable "ecr_rules" {
  type = map(object({
    priority = number
    description = optional(string)
    action_type = string
    selection = object({
      tag_status = string
      count_type = string
      count_number = number
      count_unit = optional(string, null)
    })
  }))
  default = {
    keep_image = {
      priority = 90
      description = "keep last 50 images"
      action_type = "expire"
      selection = {
        tag_status = "any"
        count_type = "imageCountMoreThan"
        count_number = 50
        count_unit = ""
      }
    }
    remove_untagged_image = {
      priority = 10
      description = "remove untagged images"
      action_type = "expire"
      selection = {
        tag_status = "untagged"
        count_type = "sinceImagePushed"
        count_number = 1
        count_unit = "days"
      }
    }
  }
}
