variable "security_groups" {
  type = list(object({
    name                     = string
    description              = string
    vpc_id                   = string
    ingress_rules            = list(string)
    ingress_cidr_blocks      = optional(list(string))
    ingress_ipv6_cidr_blocks = optional(list(string))
    ingress_self             = optional(list(bool))
    egress_rules             = list(string)
    egress_cidr_blocks       = optional(list(string))
    egress_ipv6_cidr_blocks  = optional(list(string))
    egress_self              = optional(list(bool))
  }))
}

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))
  default     = null
}
