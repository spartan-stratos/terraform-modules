variable "security_groups" {
  description = <<EOT
A list of objects defining custom security groups. Each security group object should include the following properties:
- `name` (string): The name of the security group.
- `description` (string): A description of the security group's purpose.
- `vpc_id` (string): The VPC ID where the security group will be created.
- `ingress_rules` (list(string)): A list of ingress rule names defined in the `rules` variable.
- `ingress_cidr_blocks` (optional, list(string)): CIDR blocks to allow in the ingress rules. Default is an empty list.
- `ingress_ipv6_cidr_blocks` (optional, list(string)): IPv6 CIDR blocks to allow in the ingress rules. Default is an empty list.
- `ingress_self` (optional, bool): Whether to allow self-referencing ingress rules. Default is `false`.
- `egress_rules` (list(string)): A list of egress rule names defined in the `rules` variable.
- `egress_cidr_blocks` (optional, list(string)): CIDR blocks to allow in the egress rules. Default is an empty list.
- `egress_ipv6_cidr_blocks` (optional, list(string)): IPv6 CIDR blocks to allow in the egress rules. Default is an empty list.
- `egress_self` (optional, bool): Whether to allow self-referencing egress rules. Default is `false`.
EOT
  type = list(object({
    name                     = string
    description              = string
    vpc_id                   = string
    ingress_rules            = list(string)
    ingress_cidr_blocks      = optional(list(string), [])
    ingress_ipv6_cidr_blocks = optional(list(string), [])
    ingress_self             = optional(bool, false)
    egress_rules             = list(string)
    egress_cidr_blocks       = optional(list(string), [])
    egress_ipv6_cidr_blocks  = optional(list(string), [])
    egress_self              = optional(bool, false)
  }))
  default = null
}

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))
  default     = null
}

variable "create_default_security_group" {
  description = "Flag to determine whether a default security group should be created."
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the main VPC associated with the security groups. Can be null if not provided."
  type        = string
  default     = null
}

variable "cidr_blocks" {
  description = "List of allowed CIDR blocks used to define ingress/egress rules for the security groups."
  type        = list(string)
  default     = []
}

# migration purpose
variable "custom_sg_allow_all_description" {
  description = "Custom description for security group allow all `aws_security_group.allow_all`."
  type        = string
  default     = null
}

variable "custom_sg_allow_all_within_vpc_description" {
  description = "Custom description for security group allow all within vpc `aws_security_group.allow_all_within_vpc`."
  type        = string
  default     = null
}

variable "custom_sg_allow_all_within_vpc_egress_ipv6_cidr_blocks" {
  description = "Custom IPv6 CIDR blocks to allow in the egress rules for the security group allow_all_within_vpc"
  type        = list(string)
  default     = ["::/0"]
}
