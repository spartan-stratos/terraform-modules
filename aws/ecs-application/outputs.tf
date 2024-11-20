output "alb_target_group_arn" {
  description = "The ALB ARN of ECS application"
  value       = aws_lb_target_group.main.arn
}

output "application_domain_name" {
  description = "The domain name of ECS application"
  value       = aws_route53_record.main.fqdn
}

output "ecs_service_name" {
  description = "The ECS service name"
  value       = aws_ecs_service.main.name
}

output "container_definitions" {
  description = "The container definitions of ECS application"
  value       = local.container_definitions
}

output "additional_container_definitions" {
  description = "The additional container definitions of ECS application"
  value       = var.additional_container_definitions
}
