module "eks_service" {
  source = "../"

  cluster_name = "my-eks-cluster"
  eks_oidc_provider = {
    arn = "arn:aws:iam::123456789012:oidc-provider/my-eks-cluster-oidc-provider"
  }
  alb_dns         = "my-alb-dns"
  service         = "my-service"
  route53_zone_id = "my-route53-zone-id"
  region          = "us-west-2"
}
