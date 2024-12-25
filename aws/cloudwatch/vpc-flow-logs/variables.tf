variable "retention_in_days" {
  description = "The number of days to retain log events"
  type        = number
  default     = 90
}

variable "traffic_type" {
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL"
  type        = string
  default     = "ALL"
}

variable "vpc_id" {
  description = "The ID of the VPC to monitor"
  type        = string
}

variable "group_name" {
  description = "The name use to generate CloudWatch log group to send VPC flow logs to"
  type        = string
}
