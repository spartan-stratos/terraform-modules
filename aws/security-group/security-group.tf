resource "aws_vpc_security_group_ingress_rule" "test" {
  for_each = {
    for sg in var.security_groups :
    sg.name => {
      security_group_id = aws_security_group.this[sg.name].id
      rules             = sg.ingress_rules
    }
  }

  security_group_id = each.value.security_group_id

  dynamic "rule" {
    for_each = each.value.rules
    content {
      from_port   = rule.value.from_port
      to_port     = rule.value.to_port
      ip_protocol = rule.value.protocol
      cidr_ipv4   = lookup(rule.value, "cidr_blocks", [])
      cidr_ipv6   = lookup(rule.value, "ipv6_cidr_blocks", [])
      description = lookup(rule.value, "description", "")
    }
  }
}
