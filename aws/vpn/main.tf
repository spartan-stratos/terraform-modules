/*
tls_private_key creates a PEM (and OpenSSH) formatted private key.
https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
*/
resource "tls_private_key" "this" {
  count     = local.create_self_signed_cert ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 2048
}

/*
tls_self_signed_cert creates a self-signed TLS certificate in PEM (RFC 1421) format.
https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert
*/
resource "tls_self_signed_cert" "this" {
  count           = local.create_self_signed_cert ? 1 : 0
  private_key_pem = tls_private_key.this[0].private_key_pem
  subject {
    common_name = var.tls_subject_common_name
  }
  validity_period_hours = var.tls_validity_period_hours
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "ipsec_end_system",
    "ipsec_tunnel",
    "any_extended",
    "cert_signing"
  ]
}

/*
aws_acm_certificate allows requesting and management of certificates from the Amazon Certificate Manager.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
*/
resource "aws_acm_certificate" "this" {
  count            = local.create_self_signed_cert ? 1 : 0
  private_key      = tls_private_key.this[0].private_key_pem
  certificate_body = tls_self_signed_cert.this[0].cert_pem
  tags = merge(
    {
      Name = var.tls_subject_common_name
    },
    var.tags,
  )
}

/*
aws_vpc provides details about a specific VPC.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
*/
data "aws_vpc" "this" {
  id = var.endpoint_vpc_id
}

/*
aws_cloudwatch_log_group manages an AWS CloudWatch log group.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
*/
resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.cloudwatch_log_group_name_prefix}${var.endpoint_name}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  tags              = var.tags
}

/*
aws_cloudwatch_log_stream creates a log stream within a CloudWatch log group.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream
*/
resource "aws_cloudwatch_log_stream" "this" {
  log_group_name = aws_cloudwatch_log_group.this.name
  name           = "connection-log"
}

/*
aws_security_group defines a security group with egress rules in AWS.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
*/
resource "aws_security_group" "this" {
  name        = "client-vpn-endpoint-${var.endpoint_name}"
  description = "Egress All. Used for other groups where VPN access is required. "
  vpc_id      = var.endpoint_vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

/*
aws_ec2_client_vpn_endpoint creates a VPN endpoint in AWS for secure client access.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint
*/
resource "aws_ec2_client_vpn_endpoint" "this_sso" {
  count                  = var.create_endpoint ? 1 : 0
  description            = var.endpoint_name
  vpc_id                 = var.endpoint_vpc_id
  server_certificate_arn = var.certificate_arn != null ? var.certificate_arn : aws_acm_certificate.this[0].arn
  client_cidr_block      = var.endpoint_client_cidr_block
  split_tunnel           = var.enable_split_tunnel
  self_service_portal    = var.enable_service_portal
  transport_protocol     = var.transport_protocol
  dns_servers            = var.use_vpc_internal_dns ? [cidrhost(data.aws_vpc.this.cidr_block, 2)] : var.dns_servers
  security_group_ids     = [aws_security_group.this.id]
  authentication_options {
    type                           = "federated-authentication"
    saml_provider_arn              = var.saml_provider_arn
    self_service_saml_provider_arn = var.self_service_saml_provider_arn
  }
  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.this.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.this.name
  }
  tags = merge(
    {
      Name = var.endpoint_name
    },
    var.tags,
  )
}

/*
aws_ec2_client_vpn_network_association associates a VPN endpoint with a VPC subnet.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association
*/
resource "aws_ec2_client_vpn_network_association" "this_sso" {
  for_each               = var.create_endpoint ? toset(var.endpoint_subnets) : toset([])
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this_sso[0].id
  subnet_id              = each.value
}

/*
aws_ec2_client_vpn_authorization_rule allows access to specific network CIDRs for client VPN.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule
*/
resource "aws_ec2_client_vpn_authorization_rule" "this_sso_to_dns" {
  count                  = var.create_endpoint && var.use_vpc_internal_dns ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this_sso[0].id
  target_network_cidr    = "${cidrhost(data.aws_vpc.this.cidr_block, 2)}/32" # 0.0.0.0/0
  authorize_all_groups   = true
  description            = "Authorization for ${var.endpoint_name} to DNS"
}

/*
aws_ec2_client_vpn_authorization_rule configures access rules for each specified CIDR and access group.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule
*/
resource "aws_ec2_client_vpn_authorization_rule" "this" {
  for_each               = var.create_endpoint ? var.authorization_rules : {}
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this_sso[0].id
  target_network_cidr    = split(",", each.value)[0]
  access_group_id        = split(",", each.value)[1]
  description            = "Rule name: ${each.key}"
}

/*
aws_ec2_client_vpn_authorization_rule applies authorization to all groups for specified CIDRs.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule
*/
resource "aws_ec2_client_vpn_authorization_rule" "this_all_groups" {
  for_each               = var.create_endpoint ? var.authorization_rules_all_groups : {}
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this_sso[0].id
  target_network_cidr    = each.value
  authorize_all_groups   = true
  description            = "Rule name: ${each.key}"
}

/*
aws_ec2_client_vpn_route sets routes for VPN connections to reach additional destination CIDRs.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route
*/
resource "aws_ec2_client_vpn_route" "this_sso" {
  for_each               = var.create_endpoint ? { for r in var.additional_routes : "${r.subnet_id}:${r.destination_cidr_block}" => r } : {}
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this_sso[0].id
  destination_cidr_block = each.value.destination_cidr_block
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.this_sso[each.value.subnet_id].subnet_id
  description            = "From ${each.value.subnet_id} to ${each.value.destination_cidr_block}"
}
