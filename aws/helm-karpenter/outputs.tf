# Karpenter Module Outputs

# IAM Role Information
output "controller_role_arn" {
  description = "ARN of the Karpenter controller IAM role"
  value       = aws_iam_role.karpenter_controller.arn
}

output "controller_role_name" {
  description = "Name of the Karpenter controller IAM role"
  value       = aws_iam_role.karpenter_controller.name
}

output "node_role_arn" {
  description = "ARN of the Karpenter node IAM role"
  value       = aws_iam_role.karpenter_node.arn
}

output "node_role_name" {
  description = "Name of the Karpenter node IAM role"
  value       = aws_iam_role.karpenter_node.name
}

output "node_instance_profile_arn" {
  description = "ARN of the Karpenter node instance profile"
  value       = aws_iam_instance_profile.karpenter_node.arn
}

# NodePool Configuration
output "node_pools" {
  description = "Map of deployed NodePool configurations (after preset merging)"
  value       = local.transformed_node_pools
}

# Preset Information
output "available_presets" {
  description = "List of available NodePool presets"
  value       = keys(local.nodepool_presets)
}

# Helm Release Information
output "helm_release_version" {
  description = "Deployed Karpenter Helm chart version"
  value       = var.karpenter_version
}

output "helm_release_namespace" {
  description = "Kubernetes namespace where Karpenter is deployed"
  value       = var.karpenter_namespace
}
