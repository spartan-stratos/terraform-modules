variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    vpc_id      = string
    ingress_rules = map(object({
      from_port        = string
      to_port          = string
      protocol         = string
      cidr_blocks      = string
      ipv6_cidr_blocks = string
      description      = string
    }))
  }))
}
