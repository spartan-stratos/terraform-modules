locals {
  argocd_projects = {
    spartan-eks-dev = {
      project_name        = "spartan-eks-dev"
      description         = "Demo Argo CD Dev project"
      github_repositories = ["web-platform", "service-platform"]
    }
    spartan-eks-prod = {
      project_name        = "spartan-eks-prod"
      description         = "Demo Argo CD Prod project"
      github_repositories = ["web-platform", "service-platform"]
    }
  }
}

module "argocd" {
  source = "../"

  domain_name = "example.com"

  enabled_aws_management_role = true


  slack_token = "xobx-1234"

  github_app = {
    name            = "argocd"
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
  for_each = local.argocd_projects


  project_name = each.value.project_name
  description  = each.value.description

  github_app = {
    name            = "argocd-spartan-dev"
    app_id          = 123456
    installation_id = 6543221
    private_key     = "secret"
    organization    = "spartan"
  }


  github_repositories = each.value.github_repositories

  group_roles = {
    "spartan-p00041-iaas"   = ["applications, *, *, allow"],
    "spartan-p00041-member" = ["applications, write, spartan-eks-dev/*, allow"],
    "spartan-p00041-admin"  = ["applications, *, *, allow"]
  }
  depends_on = [module.argocd]
}

module "argocd_applications" {
  source = "../modules/argocd-application"
  applications = {
    "service-platform-dev" = {
      name                     = "service-platform"
      environment              = "dev"
      project_name             = "spartan-eks-dev" #same with cluster name
      destination_cluster_name = "spartan-eks-dev"
      namespace                = "service-platform"
      repo_url                 = "github.com/spartan-stratos/gitops-repo"
    },
    "web-platform-dev" = {
      name                     = "web-platform"
      environment              = "dev"
      project_name             = "spartan-eks-dev" #same with cluster name
      destination_cluster_name = "spartan-eks-dev"
      namespace                = "web-platform"
      repo_url                 = "github.com/spartan-stratos/gitops-repo"
    },
    "serivce-platform-prod" = {
      name                     = "service-platform"
      environment              = "prod"
      project_name             = "spartan-eks-prod" #same with cluster name
      destination_cluster_name = "spartan-eks-prod"
      namespace                = "service-platform"
      repo_url                 = "github.com/spartan-stratos/gitops-repo"
    }
  }


  depends_on = [module.argocd_projects]
}

