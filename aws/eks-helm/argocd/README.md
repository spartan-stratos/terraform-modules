# EKS-Helm ArgoCD

Terraform module which install an ArgoCD to EKS cluster and configure the necessary role and permissions.

## Usage

### Install ArgoCD 

```hcl
module "argocd" {
  source = "github.com/spartan-stratos/terraform-modules//aws/eks-helm/argocd?ref=v0.2.6"

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
      repo_url                 = "github.com/...."
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
```

## Examples

- [Example](./examples/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.16.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.90.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argocd_projects"></a> [argocd\_projects](#module\_argocd\_projects) | ./modules/argocd-project | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.github_app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [aws_iam_policy_document.allow_assume_remote_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_applications"></a> [applications](#input\_applications) | Maps of application configuration which will point to, each application will represent for a service on a envinronment | <pre>map(object({<br/>    name                     = string<br/>    environment              = string<br/>    project_name             = string<br/>    destination_cluster_name = string<br/>    namespace                = string<br/>    repo_url                 = string<br/>  }))</pre> | `{}` | no |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | Namespace to install Argo CD | `string` | `"argocd"` | no |
| <a name="input_argocd_projects"></a> [argocd\_projects](#input\_argocd\_projects) | A map defining ArgoCD projects with their configurations. | <pre>map(object({<br/>    project_name        = string       # The name of the ArgoCD project, used to uniquely identify it.<br/>    description         = string       # A brief description of the project, providing context or purpose.<br/>    github_repositories = list(string) # A list of GitHub repository names managed by the project.<br/>  }))</pre> | n/a | yes |
| <a name="input_aws_management_role"></a> [aws\_management\_role](#input\_aws\_management\_role) | AWS management role configuration, only required if enabled\_aws\_management\_role is true | <pre>object({<br/>    eks_oidc_provider_arn = string<br/>    role_name             = string<br/>  })</pre> | `null` | no |
| <a name="input_chart_url"></a> [chart\_url](#input\_chart\_url) | URL of the Argo CD Helm chart | `string` | `"https://argoproj.github.io/argo-helm"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the Argo CD Helm chart | `string` | `"7.8.14"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for ArgoCD | `string` | n/a | yes |
| <a name="input_enabled_aws_management_role"></a> [enabled\_aws\_management\_role](#input\_enabled\_aws\_management\_role) | Enable the AWS management role for cross cluster management | `bool` | `false` | no |
| <a name="input_enabled_custom_ingress"></a> [enabled\_custom\_ingress](#input\_enabled\_custom\_ingress) | To enable alb ingress and use aws load balancer controller to manage | `bool` | `false` | no |
| <a name="input_external_clusters"></a> [external\_clusters](#input\_external\_clusters) | Maps of external cluster that want to connect | <pre>map(object({<br/>    assumeRole       = string<br/>    server           = string<br/>    labels           = optional(map(any), {})<br/>    annotations      = optional(map(any), {})<br/>    namespace        = optional(string, "")<br/>    clusterResources = optional(bool, false)<br/>    config           = map(any)<br/>  }))</pre> | `{}` | no |
| <a name="input_github_app"></a> [github\_app](#input\_github\_app) | GitHub App configuration to use for Argo CD | <pre>object({<br/>    name            = string<br/>    app_id          = number<br/>    installation_id = number<br/>    private_key     = string<br/>    organization    = string<br/>  })</pre> | n/a | yes |
| <a name="input_group_roles"></a> [group\_roles](#input\_group\_roles) | The project group roles define permissions in the format: 'applications, {roles}, {target-project}, allow'.<br/>- 'applications' specifies the scope (e.g., 'applications' or a specific app).<br/>- '{roles}' can be specific roles (e.g., 'admin', 'viewer') or '*' for all roles.<br/>- '{target-project}' specifies the target project (e.g., 'spartan-iaas-p0001') or '*' for all projects.<br/>- 'allow' indicates the permission type (currently only 'allow' is supported).<br/><br/>Example:<br/>  "spartan-P00001-iaas" = ["applications, *, *, allow",]<br/>  "spartan-P00001-member"  = [<br/>      "applications, *, spartan-eks-dev/*, allow"<br/>      "applications, get, *, allow"<br/>    ] | `map(list(string))` | `{}` | no |
| <a name="input_handle_tls"></a> [handle\_tls](#input\_handle\_tls) | If ArgoCD should handle TLS itself | `bool` | `false` | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | Ingress configuration for Argo CD | <pre>object({<br/>    enabled       = bool<br/>    ingress_class = optional(string, "alb")<br/>    controller    = optional(string, "aws")<br/>    annotations   = optional(map(string), {})<br/>    path          = optional(string, "/*")<br/>    pathType      = optional(string, "ImplementationSpecific")<br/>  })</pre> | <pre>{<br/>  "annotations": {<br/>    "alb.ingress.kubernetes.io/group.name": "external",<br/>    "alb.ingress.kubernetes.io/healthcheck-path": "/health/",<br/>    "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTP\": 80}, {\"HTTPS\": 443}]",<br/>    "alb.ingress.kubernetes.io/scheme": "internet-facing",<br/>    "alb.ingress.kubernetes.io/target-type": "ip",<br/>    "kubernetes.io/ingress.class": "alb"<br/>  },<br/>  "controller": "aws",<br/>  "enabled": true,<br/>  "ingress_class": "alb",<br/>  "path": "/*",<br/>  "pathType": "ImplementationSpecific"<br/>}</pre> | no |
| <a name="input_oidc_github_client_id"></a> [oidc\_github\_client\_id](#input\_oidc\_github\_client\_id) | GitHub App Client ID for OIDC | `string` | n/a | yes |
| <a name="input_oidc_github_client_secret"></a> [oidc\_github\_client\_secret](#input\_oidc\_github\_client\_secret) | GitHub App Client Secret for OIDC | `string` | n/a | yes |
| <a name="input_oidc_github_organization"></a> [oidc\_github\_organization](#input\_oidc\_github\_organization) | GitHub organization to restrict access to | `string` | n/a | yes |
| <a name="input_rbac_policies"></a> [rbac\_policies](#input\_rbac\_policies) | List of RBAC policies to apply | `list(string)` | `[]` | no |
| <a name="input_server_side_diff"></a> [server\_side\_diff](#input\_server\_side\_diff) | Enable server side diff | `bool` | `true` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | Slack | `any` | n/a | yes |
| <a name="input_slack_token"></a> [slack\_token](#input\_slack\_token) | The token to authenticate to slack, which will help application push notification to slack | `string` | `""` | no |
| <a name="input_sync_policy"></a> [sync\_policy](#input\_sync\_policy) | value | <pre>object({<br/>    automated = object({<br/>      prune    = bool<br/>      selfHeal = bool<br/>    })<br/><br/>    syncOptions = list(string)<br/><br/>    retry = object({<br/>      limit = number<br/>    })<br/>  })</pre> | <pre>{<br/>  "automated": {<br/>    "prune": true,<br/>    "selfHeal": true<br/>  },<br/>  "retry": {<br/>    "limit": 5<br/>  },<br/>  "syncOptions": [<br/>    "CreateNamespace=true",<br/>    "Retry=true"<br/>  ]<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_iam_role_arn"></a> [aws\_iam\_role\_arn](#output\_aws\_iam\_role\_arn) | n/a |
<!-- END_TF_DOCS -->