################################################################################
# IAM Role
################################################################################

output "iam_role_name" {
  description = "The name of the IAM role"
  value       = try(aws_iam_role.this[0].name, "")
}

output "iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = try(aws_iam_role.this[0].arn, var.iam_role_arn)
}

output "iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = try(aws_iam_role.this[0].unique_id, "")
}

################################################################################
# Fargate Profile
################################################################################

output "fargate_profile_pod_execution_role_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profile Pod execution role ARN"
  value       = try(aws_iam_role.this[0].arn, var.iam_role_arn)
}

output "fargate_profile_pod_execution_role_name" {
  description = "Name of the EKS Fargate Profile Pod execution role ARN"
  value       = try(aws_iam_role.this[0].name, var.iam_role_name)
}
