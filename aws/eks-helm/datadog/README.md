<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.16.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.16.1 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [random_password.cluster_agent_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | n/a | `string` | `"3.65.1"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The EKS cluster name | `any` | n/a | yes |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | The datadog api key | `string` | n/a | yes |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | The datadog app key | `string` | n/a | yes |
| <a name="input_datadog_envs"></a> [datadog\_envs](#input\_datadog\_envs) | Environment variables for datadog agents | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_datadog_site"></a> [datadog\_site](#input\_datadog\_site) | The datadog site | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where the resources will be created. | `string` | n/a | yes |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | The Helm release of the services. | `string` | `"datadog"` | no |
| <a name="input_http_check_urls"></a> [http\_check\_urls](#input\_http\_check\_urls) | The list of urls for http check | `list(string)` | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Namespace of the services. | `string` | `"datadog"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Default timeout of datadog | `number` | `1200` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_agent_auth_token"></a> [cluster\_agent\_auth\_token](#output\_cluster\_agent\_auth\_token) | n/a |
<!-- END_TF_DOCS -->