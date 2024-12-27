<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role.cluster-role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding_v1.cluster-role-binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | n/a | `string` | `"metrics-server"` | no |
| <a name="input_custom_namespaces"></a> [custom\_namespaces](#input\_custom\_namespaces) | Custom namespaces to be created during initialization | `list(string)` | `[]` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account name for binding with Cluster role | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent_cluster_role_name"></a> [agent\_cluster\_role\_name](#output\_agent\_cluster\_role\_name) | n/a |
<!-- END_TF_DOCS -->