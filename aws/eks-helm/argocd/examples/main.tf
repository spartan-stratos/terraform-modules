locals {
  atlas_dev = {
    # Application definition
    repo_url        = "github.com/spartan/argocd-atlas"
    path            = "dev"
    target_revision = "HEAD"
    # Project
    cluster_name        = "stratos-eks-dev"
    project_name        = "stratos-eks-dev"
    github_organization = "spartan"
    groups = {
      "spartan-p00041-iaas"   = ["applications, *, *, allow"],
      "spartan-p00041-member" = ["applications, write, stratos-eks-dev/*, allow"],
      "spartan-p00041-admin"  = ["applications, *, *, allow"]
    }
    destinations = [{
      name      = "stratos-eks-dev"
      namespace = ["*"]
    }]
    description = "ArgoCD Atlas Project"
  }
  atlas_prod = {
    # Application definition
    repo_url        = "github.com/spartan/argocd-atlas"
    path            = "prod"
    target_revision = "HEAD"
    # Project
    cluster_name        = "stratos-eks-prod"
    project_name        = "stratos-eks-prod"
    github_organization = "spartan"
    groups = {
      "spartan-p00041-iaas"   = ["applications, *, *, allow"],
      "spartan-p00041-member" = ["applications, write, stratos-eks-dev/*, allow"],
      "spartan-p00041-admin"  = ["applications, *, *, allow"]
    }
    destinations = [{
      name      = "stratos-eks-dev"
      namespace = ["*"]
    }]
    description = "ArgoCD Atlas Project"
  }
}

module "argocd" {
  source = "../"

  domain_name = "example.com"

  enabled_aws_management_role = true


  slack_token = "xobx-1234"

  github_app = {
    secret_name     = "argocd"
    app_id          = 123456
    installation_id = 654321
    private_key     = "key"
    organization    = "spartan-stratos"
  }
  oidc_github_organization  = "spartan-stratos"
  oidc_github_client_id     = 111111
  oidc_github_client_secret = "secret"
}

module "argocd_projects" {
  source   = "../modules/argocd-project"
  for_each = merge(local.atlas_dev, local.atlas_prod)

  github_organization = each.value.github_organization

  # Project
  project_name = each.value.project_name
  cluster_name = each.value.cluster_name
  destinations = each.value.destinations
  description  = each.value.description

  # Application
  repo_url        = each.value.repo_url
  path            = each.value.path
  target_revision = each.value.target_revision

  depends_on = [module.argocd]
}
