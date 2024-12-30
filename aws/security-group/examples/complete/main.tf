module "aws_custom_security_groups" {
  source = "../.."

  create_default_security_group = false
  security_groups = {
    "example-sg" = {
      name        = "example-sg"
      description = "Example Security Group"
      vpc_id      = "vpc-12345678"
      ingress_rules = {
        "rule1" = {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_ipv4   = "0.0.0.0/0"
          cidr_ipv6   = "::/0"
          self        = true
          description = "Example Rule 1"
        }
      }
      egress_rules = {
        "rule1" = {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_ipv4   = "0.0.0.0/0"
          cidr_ipv6   = "::/0"
          self        = true
          description = "Example Rule 2"
        }
      }
    }
  }
}

module "aws_default_security_groups" {
  source = "../.."

  create_default_security_group = true
  vpc_id                        = "vpc-12345678"
  cidr_blocks                   = ["10.0.0.0/16"]
}
