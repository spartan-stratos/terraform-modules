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

  dynamic "ingress_rule" {
    for_each = each.value.rules
    content {
      from_port   = ingress_rule.value.from_port
      to_port     = ingress_rule.value.to_port
      ip_protocol = ingress_rule.value.protocol
      cidr_ipv4   = lookup(ingress_rule.value, "cidr_blocks", [])
      cidr_ipv6   = lookup(ingress_rule.value, "ipv6_cidr_blocks", [])
      description = lookup(ingress_rule.value, "description", "")
    }
  }
}
