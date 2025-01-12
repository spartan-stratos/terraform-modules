output "eks_default_auth_role_arn" {
  value       = aws_iam_role.auth_role.arn
  description = "The ARN of the IAM role used for default EKS authentication"
}

output "aws_eks_cluster_auth_data" {
  value       = local.aws_auth_configmap_data
  description = "The ConfigMap data for managing EKS cluster authentication"
}
