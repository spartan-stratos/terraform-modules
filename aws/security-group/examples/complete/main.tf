module "aws_custom_security_groups" {
  source = "../.."

  security_groups = [
    {
      name                     = "allow_all_within_vpc"
      description              = "Allow all inbound traffic within VPC"
      vpc_id                   = "vpc-12345678"
      ingress_rules            = ["allow-all"]
      ingress_cidr_blocks      = ["0.0.0.0/0"]
      ingress_ipv6_cidr_blocks = ["::/0"]
      egress_rules             = ["allow-all"]
      egress_cidr_blocks       = ["0.0.0.0/0"]
    }
  ]
}
