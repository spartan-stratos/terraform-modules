locals {
  argocd_projects = {
    spartan-eks-dev = {
      project_name               = "project"
      github_organization        = "spartan-stratos"
      description                = "Demo Argo CD project"
      github_repositories        = ["argocd"]
      argocd_app_installation_id = 123456
    }
    spartan-eks-prod = {
      project_name               = "project"
      github_organization        = "spartan-stratos"
      description                = "Demo Argo CD project"
      github_repositories        = ["argocd"]
      argocd_app_installation_id = 123456
    }
  }
}

module "argocd" {
  source = "../"

  domain_name = "example.com"

  enabled_alb_ingress         = true
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
    id          = 123456
    private_key = "key"
  }

  # Project Team Roles Permission
  argocd_projects = local.argocd_projects

  project_group_roles = {
    "spartan-iaas-p1"  = ["applications, *, *, allow"],
    "spartan-dev-p1"   = ["applications, write, spartan-eks-dev/*, allow"],
    "spartan-admin-p1" = ["applications, *, *, allow"]
  }

  oidc_github_organization  = "spartan-stratos"
  oidc_github_client_id     = 111111
  oidc_github_client_secret = "secret"
}