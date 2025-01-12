output "aws_eks_cluster" {
  value       = aws_eks_cluster.master
  sensitive   = true
  description = "The EKS cluster master details, including API server endpoint and certificate authority"
}

output "aws_security_group_cluster" {
  value       = aws_security_group.cluster
  description = "The security group applied to the EKS cluster for network control"
}

output "oidc_provider" {
  value       = aws_iam_openid_connect_provider.eks
  description = "The OpenID Connect (OIDC) provider associated with the EKS cluster for IAM roles"
}

output "datadog_agent_cluster_role_name" {
  # we need to output a var because it has a default value
  value       = var.datadog_agent_cluster_role_name
  description = "Name of the ClusterRole to create in order to configure Datadog Agents"
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.master.vpc_config[0].cluster_security_group_id
}
