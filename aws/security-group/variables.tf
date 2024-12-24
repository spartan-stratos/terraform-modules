variable "security_groups" {
  description = "List of security group configurations"
  type = list(object({
    name                     = string
    description              = string
    vpc_id                   = string
    ingress_rules            = list(string)
    ingress_cidr_blocks      = list(string)
    ingress_ipv6_cidr_blocks = list(string)
    egress_rules             = list(string)
    egress_cidr_blocks       = list(string)
    egress_ipv6_cidr_blocks  = list(string)
  }))
}

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))
  default     = null
}
