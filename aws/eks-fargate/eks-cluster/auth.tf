module "auth" {
  source = "../eks-cluster/modules/auth"

  name                = local.cluster_name
  environment         = var.environment
  aws_eks_cluster_arn = module.cluster.aws_eks_cluster.arn

  depends_on = [module.cluster, module.fargate_profile]
}
