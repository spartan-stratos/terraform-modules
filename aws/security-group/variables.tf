variable "security_groups" {
  description = <<EOT
A list of objects defining custom security groups. Each security group object should include the following properties:
- `name` (string): The name of the security group.
- `description` (string): A description of the security group's purpose.
- `vpc_id` (string): The VPC ID where the security group will be created.
- `ingress_rules` (list(string)): A list of ingress rule names defined in the `rules` variable.
- `ingress_cidr_blocks` (optional, list(string)): CIDR blocks to allow in the ingress rules. Default is an empty list.
- `ingress_ipv6_cidr_blocks` (optional, list(string)): IPv6 CIDR blocks to allow in the ingress rules. Default is an empty list.
- `ingress_self` (optional, list(bool)): Whether to allow self-referencing ingress rules. Default is an empty list.
- `egress_rules` (list(string)): A list of egress rule names defined in the `rules` variable.
- `egress_cidr_blocks` (optional, list(string)): CIDR blocks to allow in the egress rules. Default is an empty list.
- `egress_ipv6_cidr_blocks` (optional, list(string)): IPv6 CIDR blocks to allow in the egress rules. Default is an empty list.
- `egress_self` (optional, list(bool)): Whether to allow self-referencing egress rules. Default is an empty list.
EOT
  type = list(object({
    name                     = string
    description              = string
    vpc_id                   = string
    ingress_rules            = list(string)
    ingress_cidr_blocks      = optional(list(string), [])
    ingress_ipv6_cidr_blocks = optional(list(string), [])
    egress_rules             = list(string)
    egress_cidr_blocks       = optional(list(string), [])
    egress_ipv6_cidr_blocks  = optional(list(string), [])
  }))
  default = null
}
