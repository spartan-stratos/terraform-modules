resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
}

locals {
  # Flatten the list of security groups and their ingress rules
  flattened_ingress_rules = flatten([
    for sg_key, sg in var.security_groups : [
      for rule_key, rule in sg.ingress_rules : {
        security_group_name = sg_key
        rule_key            = rule_key
        from_port           = rule.from_port
        to_port             = rule.to_port
        ip_protocol         = rule.protocol
        cidr_blocks         = rule.cidr_blocks
        ipv6_cidr_blocks    = rule.ipv6_cidr_blocks
        description         = rule.description
      }
    ]
  ])
}

resource "aws_vpc_security_group_ingress_rule" "test" {
  for_each = tomap({
    for rule in local.flattened_ingress_rules :
    "${rule.security_group_name}_${rule.rule_key}" => rule
  })

  security_group_id = aws_security_group.this[each.value.security_group_name].id

  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
  cidr_ipv4   = each.value.cidr_blocks
  description = each.value.description
}

variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    vpc_id      = string
    ingress_rules = optional(map(object({
      from_port        = optional(number, null) # Default to null if not provided
      to_port          = optional(number, null) # Default to null if not provided
      protocol         = optional(string, null) # Default to null if not provided
      cidr_blocks      = optional(string, null) # Default to null if not provided
      ipv6_cidr_blocks = optional(string, null) # Default to null if not provided
      description      = optional(string, null) # Default to null if not provided
    })), null)                                  # Default the whole `ingress_rules` map to null if not provided
  }))
  default = null # Default to null for the whole security_groups map
}
