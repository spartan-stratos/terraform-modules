output "name" {
  description = "Amplify App name"
  value       = aws_amplify_app.this.name
}

output "arn" {
  description = "Amplify App ARN"
  value       = aws_amplify_app.this.arn
}

output "backend_environment_name" {
  description = "Created backend environment name"
  value       = aws_amplify_backend_environment.this.environment_name
}

output "backend_environment_arn" {
  description = "Created backend environment arn"
  value       = aws_amplify_backend_environment.this.arn
}

output "role_policy_name" {
  description = "Created role policy name"
  value       = aws_iam_role_policy.amplify_backend.name
}
