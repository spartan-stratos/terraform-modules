/*
aws_security_group allow_all creates a security group that permits all inbound and outbound traffic.
Useful for testing purposes; consider more restrictive rules in production.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
*/
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.this.id

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

/*
aws_security_group allow_all_within_vpc creates a security group that allows all traffic within the VPC.
Allows both inbound and outbound communication between resources within the same VPC.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
*/
resource "aws_security_group" "allow_all_within_vpc" {
  name        = "allow_all_within_vpc"
  description = "Allow all inbound traffic within vpc"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port        = "0"
    to_port          = "0"
    protocol         = "-1"
    cidr_blocks      = [aws_vpc.this.cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port        = "0"
    to_port          = "0"
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

/*
aws_security_group allow_all_within_cloud creates a security group that allow all from cloud cidr_blocks.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
*/
resource "aws_security_group" "allow_all_within_cloud" {
  count       = var.enabled_allow_all_within_cloud ? 1 : 0
  name        = "allow_all_within_cloud"
  description = "Allow all inbound traffic from all bird cloud cidrs"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
