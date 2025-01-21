output "aws_launch_template_arn" {
  value       = aws_launch_template.this.arn
  description = "The ARN of the launch template."
}

output "aws_launch_template_id" {
  value       = aws_launch_template.this.id
  description = "The id of the launch template."
}

output "aws_autoscaling_group_arn" {
  value       = aws_autoscaling_group.this.arn
  description = "ARN for this Auto Scaling Group"
}

output "aws_autoscaling_group_id" {
  value       = aws_autoscaling_group.this.id
  description = "Auto Scaling Group id."
}
