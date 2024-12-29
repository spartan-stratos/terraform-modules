resource "aws_vpc_security_group_ingress_rule" "test" {
  for_each = {
    for sg in var.security_groups :
    sg.name => {
      security_group_id = aws_security_group.this[sg.name].id
      rules             = sg.ingress_rules
    }
  }

  security_group_id = each.value.security_group_id

  from_port   = each.value.rule.from_port
  to_port     = each.value.rule.to_port
  ip_protocol = each.value.rule.protocol
  cidr_ipv4   = lookup(each.value.rule, "cidr_blocks", [])
  cidr_ipv6   = lookup(each.value.rule, "ipv6_cidr_blocks", [])
  description = lookup(each.value.rule, "description", "")
}
