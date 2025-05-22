module "eks_helm_opa" {
  source = "github.com/spartan-stratos/terraform-modules//aws/eks-helm/opa?ref=v0.3.0"

  helm_release_name  = "opa"
  namespace          = "spartan"
  helm_chart_version = "0.1.13"
}