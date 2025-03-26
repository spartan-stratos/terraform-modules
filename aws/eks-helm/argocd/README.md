<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.88.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.17.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.36 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.90.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.36.0 |

## Modules

No modules. 

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret.github_app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [aws_iam_policy_document.allow_assume_remote_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_management_role"></a> [aws\_management\_role](#input\_aws\_management\_role) | AWS management role configuration, only required if enabled\_aws\_management\_role is true | <pre>object({<br/>    eks_oidc_provider_arn = string<br/>    role_name             = string<br/>  })</pre> | `null` | no |
| <a name="input_chart_url"></a> [chart\_url](#input\_chart\_url) | URL of the Argo CD Helm chart | `string` | `"https://argoproj.github.io/argo-helm"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the Argo CD Helm chart | `string` | `"7.8.14"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for ArgoCD | `string` | n/a | yes |
| <a name="input_enabled_alb_ingress"></a> [enabled\_alb\_ingress](#input\_enabled\_alb\_ingress) | To enable alb ingress and use aws load balancer controller to manage | `bool` | `true` | no |
| <a name="input_enabled_aws_management_role"></a> [enabled\_aws\_management\_role](#input\_enabled\_aws\_management\_role) | Enable the AWS management role for cross cluster management | `bool` | `false` | no |
| <a name="input_external_clusters"></a> [external\_clusters](#input\_external\_clusters) | List of maps of external cluster that want to connect | <pre>map(object({<br/>    assumeRole       = string<br/>    server           = string<br/>    labels           = optional(map(any), {})<br/>    annotations      = optional(map(any), {})<br/>    namespace        = optional(string, "")<br/>    clusterResources = optional(bool, false)<br/>    config           = map(any)<br/>  }))</pre> | `{}` | no |
| <a name="input_github_app"></a> [github\_app](#input\_github\_app) | GitHub App configuration to use for Argo CD | <pre>object({<br/>    id          = number<br/>    private_key = string<br/>  })</pre> | n/a | yes |
| <a name="input_handle_tls"></a> [handle\_tls](#input\_handle\_tls) | If ArgoCD should handle TLS itself | `bool` | `false` | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | Ingress configuration for Argo CD | <pre>object({<br/>    enabled       = bool<br/>    ingress_class = optional(string, "")<br/>    controller    = optional(string, "generic")<br/>  })</pre> | <pre>{<br/>  "enabled": false<br/>}</pre> | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to install Argo CD | `string` | `"argocd"` | no |
| <a name="input_oidc_github_client_id"></a> [oidc\_github\_client\_id](#input\_oidc\_github\_client\_id) | GitHub App Client ID for OIDC | `string` | n/a | yes |
| <a name="input_oidc_github_client_secret"></a> [oidc\_github\_client\_secret](#input\_oidc\_github\_client\_secret) | GitHub App Client Secret for OIDC | `string` | n/a | yes |
| <a name="input_oidc_github_orgs"></a> [oidc\_github\_orgs](#input\_oidc\_github\_orgs) | GitHub organization to restrict access to | `set(string)` | n/a | yes |
| <a name="input_rbac_policies"></a> [rbac\_policies](#input\_rbac\_policies) | List of RBAC policies to apply | `list(string)` | `[]` | no |
| <a name="input_server_side_diff"></a> [server\_side\_diff](#input\_server\_side\_diff) | Enable server side diff | `bool` | `true` | no |
| <a name="input_slack_token"></a> [slack\_token](#input\_slack\_token) | The token to authenticate to slack, which will help application push notification to slack | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->