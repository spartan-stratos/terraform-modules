/*
aws_lb provides an external Application Load Balancer resource.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
*/
resource "aws_lb" "main" {
  name                       = "${var.name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = concat([aws_security_group.alb.id], var.security_groups)
  subnets                    = var.public_subnets
  idle_timeout               = var.idle_timeout
  enable_deletion_protection = false

  tags = merge({
    Name = "${var.name}-alb"
  }, var.tags)
}

/*
aws_alb_target_group provides a HTTP Target Group resource for use with Load Balancer resources.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
*/
resource "aws_alb_target_group" "main" {
  name        = "${var.name}-tg-http"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }

  tags = merge({
    Name = "${var.name}-tg-http"
  }, var.tags)
}

/*
aws_alb_listener provides a Load Balancer Listener resource to redirect to https listener.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
*/
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

/*
aws_alb_listener provides a Load Balancer Listener resource to redirect traffic to target group.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
*/
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.main.id
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = var.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }
}