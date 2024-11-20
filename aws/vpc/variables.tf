variable "name" {
  description = "The name of your VPC"
  type        = string
}

variable "region" {
  description = "The region of the VPC"
  type        = string
}

variable "environment" {
  description = "The environment of this VPC"
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
