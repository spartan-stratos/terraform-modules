/*
aws_security_group provides a security group resource for ECS service.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group.html
*/
resource "aws_security_group" "this" {
  count = var.use_alb ? 1 : 0

  vpc_id      = var.vpc_id
  name        = "${var.name}-sg"
  description = "Allow inbound HTTP traffic to service from ALB only"

  ingress {
    description     = "Allow from ALB only"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = var.alb_security_groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
  }
}
