output "security_group_ids" {
  description = "Map of security group names to their IDs"
  value       = { for sg in aws_security_group.this : sg.name => sg.id }
}
