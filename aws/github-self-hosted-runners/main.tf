resource "aws_launch_template" "this" {
  name        = "github_runner_launch_template"
  description = "Launch Template for GitHub Runners"

  image_id               = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(templatefile("${path.module}/scripts/bootstrap.tmpl", { GITHUB_ORG = var.org_name, GITHUB_ACTIONS_RUNNER_REGISTRATION_TOKEN = var.github_actions_runner_registration_token, RUNNER_VERSION = var.runner_version, RUNNER_HOME = var.runner_home, RUNNER_LABELS = var.runner_labels }))

  tags = {
    Name = "github_runner"
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = "github_runners_autoscaling_group"
  health_check_type         = "EC2"
  health_check_grace_period = var.health_check_grace_period
  desired_capacity          = var.desired_capacity
  min_size                  = var.min_size
  max_size                  = var.max_size
  vpc_zone_identifier       = var.vpc_zone_identifier
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}
