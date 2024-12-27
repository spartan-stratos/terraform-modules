<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.16.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.16.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rbac"></a> [rbac](#module\_rbac) | ./modules/rbac | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | The chart version of ingress controller | `string` | `"3.12.2"` | no |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | The Helm release of the services. | `string` | `"metrics-server"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Namespace of the services. | `string` | `"kube-system"` | no |
| <a name="input_set_container_port"></a> [set\_container\_port](#input\_set\_container\_port) | To specify the port number for a container | <pre>object({<br/>    name  = string<br/>    value = number<br/>  })</pre> | `null` | no |
| <a name="input_set_list_config"></a> [set\_list\_config](#input\_set\_list\_config) | To specify the list value of a single configs | `list(any)` | `[]` | no |
| <a name="input_set_metrics_enabled"></a> [set\_metrics\_enabled](#input\_set\_metrics\_enabled) | To allow unauthenticated access to /metrics if value is true | <pre>object({<br/>    name  = string<br/>    value = bool<br/>  })</pre> | <pre>{<br/>  "name": "metrics.enabled",<br/>  "value": false<br/>}</pre> | no |
| <a name="input_set_rbac_create"></a> [set\_rbac\_create](#input\_set\_rbac\_create) | To create EKS RBAC resources | <pre>object({<br/>    name  = string<br/>    value = bool<br/>  })</pre> | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->