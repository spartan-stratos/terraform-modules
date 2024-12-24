##########################
# Security group with name
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
##########################
resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
}

###################################
# Ingress - List of rules
# https://registry.terraform.io/providers/hashicorp/aws/5.82.2/docs/resources/security_group_rule
###################################
resource "aws_security_group_rule" "ingress_rules" {
  for_each = {
    for sg_name, sg in var.security_groups : sg_name => {
      sg_name          = sg.name
      sg_id            = aws_security_group.this[sg.name].id
      ingress_rules    = sg.ingress_rules
      cidr_blocks      = sg.ingress_cidr_blocks
      ipv6_cidr_blocks = sg.ingress_ipv6_cidr_blocks
    }
  }

  security_group_id = each.value.sg_id
  type              = "ingress"

  cidr_blocks      = each.value.cidr_blocks
  ipv6_cidr_blocks = each.value.ipv6_cidr_blocks
  description      = var.rules[each.value.ingress_rules[0]][3]
  from_port        = var.rules[each.value.ingress_rules[0]][0]
  to_port          = var.rules[each.value.ingress_rules[0]][1]
  protocol         = var.rules[each.value.ingress_rules[0]][2]
}

##################################
# Egress - List of rules
# https://registry.terraform.io/providers/hashicorp/aws/5.82.2/docs/resources/security_group_rule
##################################
resource "aws_security_group_rule" "egress_rules" {
  for_each = {
    for sg_name, sg in var.security_groups : sg_name => {
      sg_name          = sg.name
      sg_id            = aws_security_group.this[sg.name].id
      egress_rules     = sg.egress_rules
      cidr_blocks      = sg.egress_cidr_blocks
      ipv6_cidr_blocks = sg.egress_ipv6_cidr_blocks
    }
  }

  security_group_id = each.value.sg_id
  type              = "egress"

  cidr_blocks      = each.value.cidr_blocks
  ipv6_cidr_blocks = each.value.ipv6_cidr_blocks
  description      = var.rules[each.value.egress_rules[0]][3]
  from_port        = var.rules[each.value.egress_rules[0]][0]
  to_port          = var.rules[each.value.egress_rules[0]][1]
  protocol         = var.rules[each.value.egress_rules[0]][2]
}
