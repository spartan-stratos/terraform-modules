############################################
# Security Group with Name
############################################
resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
}

############################################
# Ingress Rules - CIDR Blocks
############################################
resource "aws_security_group_rule" "ingress_cidr" {
  for_each = {
    for sg_name, sg in var.security_groups : sg_name => {
      sg_name       = sg.name
      sg_id         = aws_security_group.this[sg.name].id
      ingress_rules = sg.ingress_rules
      cidr_blocks   = sg.ingress_cidr_blocks
    } if length(sg.ingress_cidr_blocks) > 0
  }

  security_group_id = each.value.sg_id
  type              = "ingress"
  cidr_blocks       = each.value.cidr_blocks

  description = var.rules[each.value.ingress_rules[0]][3]
  from_port   = var.rules[each.value.ingress_rules[0]][0]
  to_port     = var.rules[each.value.ingress_rules[0]][1]
  protocol    = var.rules[each.value.ingress_rules[0]][2]
}

############################################
# Ingress Rules - IPv6 CIDR Blocks
############################################
resource "aws_security_group_rule" "ingress_ipv6" {
  for_each = {
    for sg_name, sg in var.security_groups : sg_name => {
      sg_name          = sg.name
      sg_id            = aws_security_group.this[sg.name].id
      ingress_rules    = sg.ingress_rules
      ipv6_cidr_blocks = sg.ingress_ipv6_cidr_blocks
    } if length(sg.ingress_ipv6_cidr_blocks) > 0
  }

  security_group_id = each.value.sg_id
  type              = "ingress"
  ipv6_cidr_blocks  = each.value.ipv6_cidr_blocks

  description = var.rules[each.value.ingress_rules[0]][3]
  from_port   = var.rules[each.value.ingress_rules[0]][0]
  to_port     = var.rules[each.value.ingress_rules[0]][1]
  protocol    = var.rules[each.value.ingress_rules[0]][2]
}

############################################
# Ingress Rules - Self
############################################
resource "aws_security_group_rule" "ingress_self" {
  for_each = {
    for sg_name, sg in var.security_groups : sg_name => {
      sg_name       = sg.name
      sg_id         = aws_security_group.this[sg.name].id
      ingress_rules = sg.ingress_rules
      self          = sg.ingress_self
    } if contains(sg.ingress_self, true)
  }

  security_group_id        = each.value.sg_id
  type                     = "ingress"
  source_security_group_id = each.value.sg_id

  description = var.rules[each.value.ingress_rules[0]][3]
  from_port   = var.rules[each.value.ingress_rules[0]][0]
  to_port     = var.rules[each.value.ingress_rules[0]][1]
  protocol    = var.rules[each.value.ingress_rules[0]][2]
}

############################################
# Egress Rules - CIDR Blocks
############################################
resource "aws_security_group_rule" "egress_cidr" {
  for_each = {
    for sg_name, sg in var.security_groups : sg_name => {
      sg_name      = sg.name
      sg_id        = aws_security_group.this[sg.name].id
      egress_rules = sg.egress_rules
      cidr_blocks  = sg.egress_cidr_blocks
    } if length(sg.egress_cidr_blocks) > 0
  }

  security_group_id = each.value.sg_id
  type              = "egress"
  cidr_blocks       = each.value.cidr_blocks

  description = var.rules[each.value.egress_rules[0]][3]
  from_port   = var.rules[each.value.egress_rules[0]][0]
  to_port     = var.rules[each.value.egress_rules[0]][1]
  protocol    = var.rules[each.value.egress_rules[0]][2]
}

############################################
# Egress Rules - IPv6 CIDR Blocks
############################################
resource "aws_security_group_rule" "egress_ipv6" {
  for_each = {
    for sg_name, sg in var.security_groups : sg_name => {
      sg_name          = sg.name
      sg_id            = aws_security_group.this[sg.name].id
      egress_rules     = sg.egress_rules
      ipv6_cidr_blocks = sg.egress_ipv6_cidr_blocks
    } if length(sg.egress_ipv6_cidr_blocks) > 0
  }

  security_group_id = each.value.sg_id
  type              = "egress"
  ipv6_cidr_blocks  = each.value.ipv6_cidr_blocks

  description = var.rules[each.value.egress_rules[0]][3]
  from_port   = var.rules[each.value.egress_rules[0]][0]
  to_port     = var.rules[each.value.egress_rules[0]][1]
  protocol    = var.rules[each.value.egress_rules[0]][2]
}

############################################
# Egress Rules - Self
############################################
resource "aws_security_group_rule" "egress_self" {
  for_each = {
    for sg_name, sg in var.security_groups : sg_name => {
      sg_name      = sg.name
      sg_id        = aws_security_group.this[sg.name].id
      egress_rules = sg.egress_rules
      self         = sg.egress_self
    } if contains(sg.egress_self, true)
  }

  security_group_id        = each.value.sg_id
  type                     = "egress"
  source_security_group_id = each.value.sg_id

  description = var.rules[each.value.egress_rules[0]][3]
  from_port   = var.rules[each.value.egress_rules[0]][0]
  to_port     = var.rules[each.value.egress_rules[0]][1]
  protocol    = var.rules[each.value.egress_rules[0]][2]
}
