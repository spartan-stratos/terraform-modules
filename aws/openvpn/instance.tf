/*
https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
 */
resource "random_password" "this" {
  length  = 24
  special = false
}

/*
https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
 */
resource "tls_private_key" "management_ssh_key" {
  count     = var.create_management_key_pair ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "management_ssh_key" {
  count      = var.create_management_key_pair ? 1 : 0
  key_name   = var.vpn_name
  public_key = tls_private_key.management_ssh_key[0].public_key_openssh
}

/*
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
 */
resource "aws_instance" "this" {
  ami           = data.aws_ami.debian.id
  instance_type = var.instance_type
  key_name      = var.create_management_key_pair ? var.vpn_name : null
  subnet_id     = var.subnet_id

  vpc_security_group_ids = concat(
    var.extra_sg_ids,
    [aws_security_group.this.id],
  )

  root_block_device {
    encrypted = true
  }

  user_data_replace_on_change = true
  user_data                   = templatefile("${path.module}/scripts/install_openvpn.sh", local.openvpn_config)

  tags = {
    "Name" = var.vpn_name
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }
}

/*
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
 */
resource "aws_eip" "this" {
  instance = aws_instance.this.id
  domain   = "vpc"
}
