locals {
  argocd_projects = {
    atlas = {
      projects = {
        stratos-eks-dev = {
          project_name = "stratos-eks-dev"
          description  = "Demo ArgoCD Dev Project"
          destinations = [{
            name      = "stratos-eks-dev"
            namespace = "*"
          }]
        }
        stratos-eks-prod = {
          project_name = "stratos-eks-prod"
          description  = "Demo ArgoCD Prod Project"
          destinations = [{
            name      = "stratos-eks-prod"
            namespace = "*"
          }]
        }
      }
      repo_name = "argocd-atlas"
      groups = {
        "spartan-p00041-iaas"   = ["applications, *, *, allow"],
        "spartan-p00041-member" = ["applications, write, stratos-eks-dev/*, allow"],
        "spartan-p00041-admin"  = ["applications, *, *, allow"]
      }
    }
    approvia = {
      projects = {
        atlas-eks-dev = {
          project_name = "approvia-eks-dev"
          description  = "Demo ArgoCD Dev Project"
          destinations = [{
            name      = "approvia-eks-dev"
            namespace = "*"
          }]
        }
        approvia-eks-prod = {
          project_name = "approvia-eks-prod"
          description  = "Demo ArgoCD Prod Project"
          destinations = [{
            name      = "approvia-eks-prod"
            namespace = "*"
          }]
        }
      }
      repo_name = "argocd-approvia"
      groups = {
        "spartan-p00042-iaas"   = ["applications, *, *, allow"],
        "spartan-p00042-member" = ["applications, write, approvia-eks-dev/*, allow"],
        "spartan-p00042-admin"  = ["applications, *, *, allow"]
      }
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
  source = "../modules/argocd-project"

  github_app = {
    name            = "argocd-spartan-dev"
    app_id          = 123456
    installation_id = 6543221
    private_key     = "secret"
    organization    = "spartan"
  }

  repo_name = local.argocd_projects.atlas.repo_name
  projects  = local.argocd_projects.atlas.projects

  github_repositories = each.value.github_repositories

  group_roles = local.argocd_projects.atlas.groups
  depends_on  = [module.argocd]
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
      repo_url                 = "github.com/spartan-stratos/infra-argocd"
    },
    "web-platform-dev" = {
      name                     = "web-platform"
      environment              = "dev"
      project_name             = "spartan-eks-dev" #same with cluster name
      destination_cluster_name = "spartan-eks-dev"
      namespace                = "web-platform"
      repo_url                 = "github.com/spartan-stratos/infra-argocd"
    },
    "serivce-platform-prod" = {
      name                     = "service-platform"
      environment              = "prod"
      project_name             = "spartan-eks-prod" #same with cluster name
      destination_cluster_name = "spartan-eks-prod"
      namespace                = "service-platform"
      repo_url                 = "github.com/spartan-stratos/infra-argocd"
    }
  }


  depends_on = [module.argocd_projects]
}

