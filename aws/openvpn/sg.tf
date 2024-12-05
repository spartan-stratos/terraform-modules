resource "aws_security_group" "this" {
  name   = var.vpn_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "egress_vpn" {
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"
}

# Allow connections to OpenVPN port
resource "aws_security_group_rule" "udp_vpn" {
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "ingress"
  from_port = "1194"
  to_port   = "1194"
  protocol  = "udp"
}

# Allow Certbot TLS renewal
resource "aws_security_group_rule" "http_vpn" {
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "ingress"
  from_port = "80"
  to_port   = "80"
  protocol  = "tcp"
}

# Allow Google OAuth 2.0 callback
resource "aws_security_group_rule" "https_vpn" {
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "ingress"
  from_port = "443"
  to_port   = "443"
  protocol  = "tcp"
}
