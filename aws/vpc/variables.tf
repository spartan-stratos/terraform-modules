variable "name" {
  description = "The name of your VPC"
  type        = string
}

variable "region" {
  description = "The region of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "availability_zone_postfixes" {
  description = "List of availability zones"
  type        = list(string)
}

variable "single_nat" {
  description = "Whether to create a single NAT gateway or one per AZ"
  type        = bool
  default     = false
}

variable "create_custom_subnets" {
  description = "Whether to create custom subnets."
  type        = bool
  default     = false
}

variable "custom_public_subnets" {
  description = "List of custom public subnets."
  type        = list(string)
  default     = []
}

variable "custom_private_subnets" {
  description = "List of custom private subnets."
  type        = list(string)
  default     = []
}

variable "create_flow_log" {
  description = "Whether to create VPC flow logs."
  type        = bool
  default     = false
}

variable "create_private_database_subnet_group" {
  description = "Whether to create private database subnet group"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "Name of associated EKS cluster"
  type        = string
  default     = null
}

variable "create_mng" {
  description = "Whether Managed Node Groups are created in this VPC"
  type        = bool
  default     = false
}
