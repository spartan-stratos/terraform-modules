module "aws_security_groups" {
  source = "../.."

  security_groups = [
    {
      name                     = "example"
      description              = "example description"
      vpc_id                   = "vpc-1234567899"
      ingress_rules            = ["example-ingress"]
      ingress_cidr_blocks      = ["0.0.0.0/0"]
      ingress_ipv6_cidr_blocks = ["::/0"]
      egress_rules             = ["example-egress"]
      egress_cidr_blocks       = ["0.0.0.0/0"]
      egress_ipv6_cidr_blocks  = ["::/0"]
    }
  ]
}
