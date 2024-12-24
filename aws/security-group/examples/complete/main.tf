module "aws_security_groups" {
  source = "../.."

  security_groups = [
    {
      name                     = "example-sg"
      description              = "Example Security Group"
      vpc_id                   = "vpc-12345678"
      ingress_rules            = ["http"]
      ingress_cidr_blocks      = ["0.0.0.0/0"]
      ingress_ipv6_cidr_blocks = []
      ingress_self             = [true]
      egress_rules             = ["https"]
      egress_cidr_blocks       = ["0.0.0.0/0"]
      egress_ipv6_cidr_blocks  = []
      egress_self              = []
    }
  ]
}
