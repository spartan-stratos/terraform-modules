resource "random_password" "this" {
  length  = 24
  special = false
}

resource "tls_private_key" "management_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "management_ssh_key" {
  key_name  = var.vpn_name
  public_key = tls_private_key.management_ssh_key.public_key_openssh
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.image_distro}-${var.image_version}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["136693071363"] # AWS
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.debian.id
  instance_type = var.instance_type
  key_name      = var.vpn_name
  subnet_id     = var.subnet_id

  vpc_security_group_ids = concat(
    var.extra_sg_ids,
    [aws_security_group.this.id],
  )

  root_block_device {
    encrypted = true
  }

  user_data_replace_on_change = true
  user_data                   = templatefile("${path.module}/init/install_openvpn.sh", local.openvpn_config)

  tags = {
    "Name" = var.vpn_name
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id
  domain   = "vpc"
}

locals {
  openvpn_config = {
    ca_cert                     = tls_self_signed_cert.ca.cert_pem
    server_cert                 = tls_locally_signed_cert.server.cert_pem
    server_private_key          = tls_private_key.server.private_key_pem
    management_password         = random_password.this.result
    openvpn_auth_oauth2_version = var.openvpn_auth_oauth2_version
    openvpn_fqdn                = local.openvpn_fqdn
    openvpn_ip_pool             = var.openvpn_ip_pool
    oauth2_client_id            = var.oauth2_client_id
    oauth2_client_secret        = var.oauth2_client_secret
    route_network_cidrs         = var.route_network_cidrs
  }
}
