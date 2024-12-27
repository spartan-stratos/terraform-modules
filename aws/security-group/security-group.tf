############################################
# Conditional Default Security Groups
############################################

resource "aws_security_group" "allow_all" {
  count = var.create_default_security_group ? 1 : 0

  name        = "allow_all"
  description = var.custom_sg_allow_all_description != null ? var.custom_sg_allow_all_description : "Allow all inbound and outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "allow_all_within_vpc" {
  count = var.create_default_security_group ? 1 : 0

  name        = "allow_all_within_vpc"
  description = var.custom_sg_allow_all_within_vpc_description != null ? var.custom_sg_allow_all_within_vpc_description : "Allow all traffic within the VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = var.custom_sg_allow_all_within_vpc_egress_ipv6_cidr_blocks
  }
}

############################################
# Custom Security Groups and Rules
############################################

resource "aws_security_group" "this" {
  for_each = var.create_default_security_group ? {} : { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
}


############################################
# Security Group Rules
############################################

############################################
# Ingress Rules - CIDR Blocks
############################################
resource "aws_vpc_security_group_ingress_rule" "ingress_cidr" {
  for_each = var.create_default_security_group ? {} : flatten([
    for sg_name, sg in var.security_groups : [
      for ingress_rule in sg.ingress_rules : {
        sg_name     = sg.name
        sg_id       = aws_security_group.this[sg.name].id
        description = var.rules[ingress_rule][3]
        from_port   = var.rules[ingress_rule][0]
        to_port     = var.rules[ingress_rule][1]
        ip_protocol = var.rules[ingress_rule][2]
        cidr_blocks = sg.ingress_cidr_blocks
      }
    ] if length(sg.ingress_cidr_blocks) > 0
  ])

  security_group_id = each.value.sg_id
  cidr_ipv4         = each.value.ipv4_cidr_blocks

  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
}


############################################
# Ingress Rules - IPv6 CIDR Blocks
############################################
resource "aws_vpc_security_group_ingress_rule" "ingress_ipv6" {
  for_each = var.create_default_security_group ? {} : flatten([
    for sg_name, sg in var.security_groups : [
      for ingress_rule in sg.ingress_rules : {
        sg_name     = sg.name
        sg_id       = aws_security_group.this[sg.name].id
        description = var.rules[ingress_rule][3]
        from_port   = var.rules[ingress_rule][0]
        to_port     = var.rules[ingress_rule][1]
        ip_protocol = var.rules[ingress_rule][2]
        cidr_blocks = sg.ingress_cidr_blocks
      }
    ] if length(sg.ingress_cidr_blocks) > 0
  ])

  security_group_id = each.value.sg_id
  cidr_ipv6         = each.value.ipv6_cidr_blocks

  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
}

############################################
# Ingress Rules - Self
############################################
resource "aws_security_group_rule" "ingress_self" {
  for_each = var.create_default_security_group ? {} : flatten([
    for sg_name, sg in var.security_groups : [
      for ingress_rule in sg.ingress_rules : {
        sg_name     = sg.name
        sg_id       = aws_security_group.this[sg.name].id
        description = var.rules[ingress_rule][3]
        from_port   = var.rules[ingress_rule][0]
        to_port     = var.rules[ingress_rule][1]
        ip_protocol = var.rules[ingress_rule][2]
        self        = sg.ingress_self
      }
    ] if sg.ingress_rules
  ])

  security_group_id        = each.value.sg_id
  type                     = "ingress"
  source_security_group_id = each.value.sg_id

  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.ip_protocol
}

############################################
# Egress Rules - CIDR Blocks
############################################
resource "aws_vpc_security_group_egress_rule" "egress_cidr" {
  for_each = var.create_default_security_group ? {} : flatten([
    for sg_name, sg in var.security_groups : [
      for ingress_rule in sg.ingress_rules : {
        sg_name     = sg.name
        sg_id       = aws_security_group.this[sg.name].id
        description = var.rules[ingress_rule][3]
        from_port   = var.rules[ingress_rule][0]
        to_port     = var.rules[ingress_rule][1]
        ip_protocol = var.rules[ingress_rule][2]
        cidr_blocks = sg.ingress_cidr_blocks
      }
    ] if length(sg.ingress_cidr_blocks) > 0
  ])

  security_group_id = each.value.sg_id
  cidr_ipv4         = each.value.cidr_blocks

  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
}

############################################
# Egress Rules - IPv6 CIDR Blocks
############################################
resource "aws_vpc_security_group_egress_rule" "egress_ipv6" {
  for_each = var.create_default_security_group ? {} : flatten([
    for sg_name, sg in var.security_groups : [
      for ingress_rule in sg.ingress_rules : {
        sg_name     = sg.name
        sg_id       = aws_security_group.this[sg.name].id
        description = var.rules[ingress_rule][3]
        from_port   = var.rules[ingress_rule][0]
        to_port     = var.rules[ingress_rule][1]
        ip_protocol = var.rules[ingress_rule][2]
        cidr_blocks = sg.ingress_cidr_blocks
      }
    ] if length(sg.ingress_cidr_blocks) > 0
  ])
  security_group_id = each.value.sg_id
  cidr_ipv6         = each.value.ipv6_cidr_blocks

  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol
}

############################################
# Egress Rules - Self
############################################
resource "aws_security_group_rule" "egress_self" {
  for_each = var.create_default_security_group ? {} : flatten([
    for sg_name, sg in var.security_groups : [
      for ingress_rule in sg.ingress_rules : {
        sg_name     = sg.name
        sg_id       = aws_security_group.this[sg.name].id
        description = var.rules[ingress_rule][3]
        from_port   = var.rules[ingress_rule][0]
        to_port     = var.rules[ingress_rule][1]
        ip_protocol = var.rules[ingress_rule][2]
        self        = sg.egress_self
      }
    ] if sg.egress_self
  ])

  security_group_id        = each.value.sg_id
  type                     = "egress"
  source_security_group_id = each.value.sg_id

  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.ip_protocol
}
