resource "aws_lb_target_group" "this" {
  count = var.is_worker ? 0 : 1

  name        = "${var.name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    enabled             = var.health_check_enabled
    healthy_threshold   = "2"
    interval            = "120"
    protocol            = "HTTP"
    port                = var.container_port
    matcher             = "200"
    timeout             = "60"
    path                = var.health_check_path
    unhealthy_threshold = "7"
  }
}

resource "aws_lb_listener_rule" "this" {
  count = var.is_worker ? 0 : 1

  listener_arn = var.aws_lb_listener_arn
  priority     = var.aws_lb_listener_rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[0].arn
  }

  condition {
    host_header {
      values = [aws_route53_record.this[0].fqdn]
    }
  }
}
