module "aws_custom_security_groups" {
  source = "../.."

  security_groups = [
    {
      name = "allow_all_within_vpc"
      ingress_rules = {
        "allow-all" = {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
          description      = "Allow all traffic"
        }
      }
    },
    {
      name = "allow_postgres_inbound"
      ingress_rules = {
        "allow-postgresql" = {
          from_port   = 5432
          to_port     = 5432
          protocol    = "tcp"
          cidr_blocks = ["10.0.0.0/16"]
          description = "Allow PostgreSQL traffic"
        }
      }
    }
  ]
}
