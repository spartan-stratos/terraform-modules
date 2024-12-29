############################################
# Custom Security Groups and Rules
############################################

resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv4" {
  for_each = { for sg, rules in var.security_groups : sg => rules.ingress_rules if length(rules.ingress_cidr_blocks) > 0 }

  security_group_id = aws_security_group.this[each.key].id
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = lookup(each.value, "protocol", "tcp")
  cidr_ipv4         = each.value.ingress_cidr_blocks
  description       = lookup(each.value, "description", null)
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv6" {
  for_each = { for sg, rules in var.security_groups : sg => rules.ingress_rules if length(rules.ingress_ipv6_cidr_blocks) > 0 }

  security_group_id = aws_security_group.this[each.key].id
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = lookup(each.value, "protocol", "tcp")
  cidr_ipv6         = each.value.ingress_ipv6_cidr_blocks
  description       = lookup(each.value, "description", null)
}

resource "aws_vpc_security_group_egress_rule" "egress_ipv4" {
  for_each = { for sg, rules in var.security_groups : sg => rules.egress_rules if length(rules.egress_cidr_blocks) > 0 }

  security_group_id = aws_security_group.this[each.key].id
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = lookup(each.value, "protocol", "tcp")
  cidr_ipv4         = each.value.egress_cidr_blocks
  description       = lookup(each.value, "description", null)
}

resource "aws_vpc_security_group_egress_rule" "egress_ipv6" {
  for_each = { for sg, rules in var.security_groups : sg => rules.egress_rules if length(rules.egress_ipv6_cidr_blocks) > 0 }

  security_group_id = aws_security_group.this[each.key].id
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = lookup(each.value, "protocol", "tcp")
  cidr_ipv6         = each.value.egress_ipv6_cidr_blocks
  description       = lookup(each.value, "description", null)
}
