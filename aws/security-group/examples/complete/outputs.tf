output "security_group_ids" {
  description = "Security group IDs created by the module"
  value       = module.aws_security_groups.security_group_ids
}
