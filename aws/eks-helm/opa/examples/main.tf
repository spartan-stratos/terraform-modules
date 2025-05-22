module "eks_helm_opa" {
  source = "github.com/spartan-stratos/terraform-modules//aws/eks-helm/opa?ref=v0.5.4"

  helm_release_name  = "opa"
  namespace          = "opa"
  helm_chart_version = "0.1.13"
  opa_image_tag      = "1.4.2"
  create_namespace   = true
}
