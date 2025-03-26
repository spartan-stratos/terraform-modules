locals {
  argocd_projects = {
    spartan_stratos = {
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

  github_app = {
    id          = 123456
    private_key = "key"
  }
  oidc_github_orgs          = toset([for org in local.argocd_projects : org.github_organization])
  oidc_github_client_id     = 111111
  oidc_github_client_secret = "secret"
}