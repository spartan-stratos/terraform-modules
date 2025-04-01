locals {
  argocd_projects = {
    spartan-eks-dev = {
      project_name        = "spartan-eks-dev"
      description         = "Demo Argo CD Dev project"
      github_repositories = ["argocd", "service-platform"]
    }
    spartan-eks-prod = {
      project_name        = "spartan-eks-prod"
      description         = "Demo Argo CD Prod project"
      github_repositories = ["argocd", "service-platform"]
    }
  }
}

module "argocd" {
  source = "../"

  domain_name = "example.com"

  enabled_aws_management_role = true

  applications = {
    "service-platform-dev" = {
      name                     = "service-platform"
      environment              = "dev"
      project_name             = "test-eks-dev" #same with cluster name
      destination_cluster_name = "test-eks-dev"
      namespace                = "service-platform"
      repo_url                 = "github.com/spartan-stratos/gitops-repo"
    },
    "web-platform-dev" = {
      name                     = "web-platform"
      environment              = "dev"
      project_name             = "test-eks-dev" #same with cluster name
      destination_cluster_name = "test-eks-dev"
      namespace                = "web-platform"
      repo_url                 = "github.com/spartan-stratos/gitops-repo"
    },
    "serivce-platform-prod" = {
      name                     = "service-platform"
      environment              = "prod"
      project_name             = "test-eks-prod" #same with cluster name
      destination_cluster_name = "test-eks-prod"
      namespace                = "service-platform"
      repo_url                 = "github.com/spartan-stratos/gitops-repo"
    }
  }

  slack_channel = "pipeline-dev"
  slack_token   = "xobx-1234"

  github_app = {
    app_id          = 123456
    installation_id = 654321
    private_key     = "key"
  }

  # Project Team Roles Permission
  argocd_projects = local.argocd_projects

  group_roles = {
    "spartan-iaas-p1"  = ["applications, *, *, allow"],
    "spartan-dev-p1"   = ["applications, write, spartan-eks-dev/*, allow"],
    "spartan-admin-p1" = ["applications, *, *, allow"]
  }

  oidc_github_organization  = "spartan-stratos"
  oidc_github_client_id     = 111111
  oidc_github_client_secret = "secret"
}