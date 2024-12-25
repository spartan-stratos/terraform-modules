output "pod_role" {
  value       = aws_iam_role.this.arn
  description = "The ARN of the IAM role for services' pods"
}
