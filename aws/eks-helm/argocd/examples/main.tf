locals {
  atlas_dev = {
    # Application definition
    repo_url = "github.com/spartan/argocd-atlas"

    path = "dev"

    target_revision = "HEAD"
    # Project
    cluster_name        = "stratos-eks-dev"
    project_name        = "atlas_dev"
    github_organization = "spartan"
    groups = {
      "admin"  = ["spartan-p00041-iaas", "spartan-p00041-admin", "spartan-p00041-leader"],
      "member" = ["spartan-p00041-member"],
    }
    destinations = [{
      name      = "stratos-eks-dev"
      namespace = ["*"]
    }]

    description = "Atlas Dev Projects"
  }

  atlas_prod = {
    # Application definition
    repo_url        = "github.com/spartan/argocd-atlas"
    path            = "prod"
    target_revision = "HEAD"
    # Project
    cluster_name        = "stratos-eks-prod"
    project_name        = "atlas_prod"
    github_organization = "spartan"

    groups = {
      "admin"  = ["spartan-p00041-iaas", "spartan-p00041-admin", "spartan-p00041-leader"],
      "viewer" = ["spartan-p00041-member"],
    }

    destinations = [{
      name      = "stratos-eks-dev"
      namespace = ["*"]
    }]

    description = "Atlas Production Projects"
  }
}

module "argocd" {
  source = "../"

  domain_name = "example.com"

  enabled_aws_management_role = true

  # For creating management account, and creating resource relating to assume policy
  aws_management_role = {
    eks_oidc_provider_arn = "arn:aws:iam::<AWS_ACCOUNT_ID>:oidc-provider/oidc.eks.<AWS_REGION>.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
    eks_oidc_provider_url = "oidc-provider/oidc.eks.<AWS_REGION>.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
    role_name             = "argocd_management"
  }

  # Repository Connection
  repositories = ["argocd-atlas"]

  # Slack Connection
  slack_token = "xobx-1234"

  # Managed Node (OPTIONAL)
  # node_selector = local.node_selector
  # tolerations   = local.tolerations

  # GitHub App
  github_app = {
    secret_name     = "argocd"
    app_id          = 123456
    installation_id = 654321
    private_key     = "key"
    organization    = "spartan-stratos"
  }

  # GitHub OAuth
  oidc_github_organization  = "spartan-stratos"
  oidc_github_client_id     = 111111
  oidc_github_client_secret = "secret"

  # Connect External Cluster (eg: stratos-eks-dev)
  external_clusters = merge(
    {
      "stratos-eks-dev" = {
        assumeRole = "arn:aws:iam::2222222222:role/external-cluster-role" # This role will be in stratos-eks-dev for argocd_management assumed
        server     = "<EXAMPLE>.us-west-2.eks.amazonaws.com"
        config = {
          awsAuthConfig = {
            clusterName = "stratos-eks-dev"
            roleARN     = "arn:aws:iam::2222222222:role/external-cluster-role" #same with assume role
          },
          tlsClientConfig = {
            insecure = false
            caData   = "<stratos-eks-dev caData>" # This get from eks cluster of dev
          }
        }
      }
    },
    { # This is must have connection for define name internal project, for example: argocd instance hosted on stratos-eks-prod, but its name is in-cluster, this one is for rename it into `stratos-eks-prod` for easier management
      "stratos-eks-prod" = {
        server = "https://kubernetes.default.svc" # This is for internal cluster
        config = {
          awsAuthConfig = {} # Leave this empty object just for internal connection
          tlsClientConfig = {
            insecure = false
            caData   = "" # Leave this empty string just for internal connection
          }
        }
      },
    }
  )
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
