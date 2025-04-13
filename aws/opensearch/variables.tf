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

variable "create_linked_role" {
  description = "Create a service linked role for Amazon OpenSearch Service to access VPC resources"
  type        = bool
  default     = false
}

variable "encrypt_at_rest_enabled" {
  description = "Whether to enable encryption of data at rest."
  type        = bool
  default     = false
}

// multi-az config
variable "zone_awareness_enabled" {
  description = "Whether zone awareness is enabled, set to true for multi-az deployment."
  type = bool
  default = false
}

variable "availability_zone_count" {
  description = "Number of availability zones to enable from 2-3."
  type = number
  default = 3
}
