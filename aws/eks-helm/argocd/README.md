<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.16.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_argocd"></a> [argocd](#provider\_argocd) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.16.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.33 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [argocd_application.this](https://registry.terraform.io/providers/argoproj-labs/argocd/latest/docs/resources/application) | resource |
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map.slack](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_secret.argocd_repo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.slack](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.argocd_admin_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |
| [kubernetes_secret.secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the Argo CD Helm chart | `string` | `"7.8.2"` | no |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | GitHub organization to watch | `string` | n/a | yes |
| <a name="input_listRepoURL"></a> [listRepoURL](#input\_listRepoURL) | List Repository URL need to be sync | <pre>list(object({<br/>    service_name = string<br/>    repoURL        = string<br/>    path           = string<br/>    targetRevision = optional(string, "v*.*.*")<br/>    value_files = optional(list(string),["values.yaml"])<br/>    namespace = string<br/>  }))</pre> | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to install Argo CD | `string` | `"argocd"` | no |
| <a name="input_slack_token"></a> [slack\_token](#input\_slack\_token) | Slack Token to notify | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argocd_admin_password"></a> [argocd\_admin\_password](#output\_argocd\_admin\_password) | n/a |
| <a name="output_argocd_namespace"></a> [argocd\_namespace](#output\_argocd\_namespace) | The namespace where Argo CD is deployed |
| <a name="output_argocd_release_name"></a> [argocd\_release\_name](#output\_argocd\_release\_name) | The name of the Argo CD Helm release |
<!-- END_TF_DOCS -->
