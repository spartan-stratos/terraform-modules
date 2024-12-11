# output "github_tf_ops_role_arn" {
#   description = "The ARN of the IAM role used for GitHub Actions operations."
#   value       = aws_iam_role.github_actions_role.arn
# }

output "role_name" {
  description = "The Name of the IAM role used for GitHub Actions operations."
  value       = aws_iam_role.github_actions_role.name
}

output "role_arn" {
  description = "The ARN of the IAM role used for GitHub Actions operations."
  value       = aws_iam_role.github_actions_role.arn
}

output "role_id" {
  description = "The ID of the IAM role used for GitHub Actions operations."
  value       = aws_iam_role.github_actions_role.id
}