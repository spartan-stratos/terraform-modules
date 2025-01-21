output "aws_launch_template_arn" {
  value       = module.github_self_host_runner.aws_launch_template_arn
  description = "The ARN of the launch template."
}

output "aws_launch_template_id" {
  value       = module.github_self_host_runner.aws_launch_template_id
  description = "The id of the launch template."
}

output "aws_autoscaling_group_arn" {
  value       = module.github_self_host_runner.aws_autoscaling_group_arn
  description = "ARN for this Auto Scaling Group"
}

output "aws_autoscaling_group_id" {
  value       = module.github_self_host_runner.aws_autoscaling_group_id
  description = "Auto Scaling Group id."
}
