variable "domain" {
  description = "The domain for creating open search"
  type        = string
}

variable "engine_version" {
  description = "The engine version of open search"
  type        = string
  default     = "OpenSearch_2.13"
}

variable "instance_count" {
  description = "The number of instance"
  type        = number
  default     = 1
}

variable "instance_size" {
  description = "The size of instance"
  type        = string
  default     = "t2.micro.search"
}

variable "principal_roles" {
  description = "List of priciple roles"
  type        = list(string)
  default     = null
}

variable "subnet_ids" {
  description = "The subnet ids of clusters"
  type        = list(string)
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs that will be used in additional to the default ones."
}

variable "ebs_enabled" {
  description = "Enable EBS"
  type        = bool
  default     = false
}

variable "ebs_storage_size" {
  description = "Enable EBS"
  type        = number
  default     = 10
}
