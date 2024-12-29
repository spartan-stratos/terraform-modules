resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
}

locals {
  # Flatten the list of security group rules into a single list of objects
  security_group_rules = flatten([
    for sg in var.security_groups : [
      for rule_key, rule in sg.ingress_rules : {
        security_group_name = sg.name
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
  # Convert the flattened list of rules into a map for `for_each`
  for_each = tomap({
    for rule in local.security_group_rules : "${rule.security_group_name}.${rule.rule_key}" => rule
  })

  security_group_id = aws_security_group.this[each.value.security_group_name].id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_blocks
  cidr_ipv6         = each.value.ipv6_cidr_blocks
  description       = each.value.description
}
