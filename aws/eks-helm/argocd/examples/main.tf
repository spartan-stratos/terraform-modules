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
  
  ingress = {
    enabled       = true
    ingress_class = "alb"
  }

  handle_tls = false

  github_app = {
    id          = 123456
    private_key = "key"
  }
  oidc_github_orgs          = toset([for org in local.argocd_projects : org.github_organization])
  oidc_github_client_id     = 111111
  oidc_github_client_secret = "secret"
}