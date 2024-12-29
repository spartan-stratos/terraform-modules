resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "test" {
  for_each = {
    for sg in var.security_groups :
    sg.name => {
      security_group_id = aws_security_group.this[sg.name].id
      rules             = sg.ingress_rules
    }
  }

  security_group_id = each.value.security_group_id

  # Iterate over ingress rules directly
  from_port   = each.value.rules.from_port
  to_port     = each.value.rules.to_port
  ip_protocol = each.value.rules.protocol
  cidr_ipv4   = lookup(each.value.rules, "cidr_blocks", [])
  cidr_ipv6   = lookup(each.value.rules, "ipv6_cidr_blocks", [])
  description = lookup(each.value.rules, "description", "")
}
