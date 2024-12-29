variable "security_groups" {
  type = list(object({
    name        = string
    description = string # Added description for the security group
    vpc_id      = string # Added VPC ID for the security group
    ingress_rules = map(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = optional(list(string), [])
      ipv6_cidr_blocks = optional(list(string), [])
      description      = optional(string)
    }))
  }))
}
