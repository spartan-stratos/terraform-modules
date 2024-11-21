# Datadog RBAC sub-module
Terraform Datadog RBAC sub-module.

## Usage
### Create Datadog RBAC
```hcl
module "datadog_rbac" {
  source  = "./modules/datadog-rbac"

  fargate_profiles        = var.fargate_profiles
  default_service_account = var.default_service_account
  custom_namespaces       = var.custom_namespaces
}
```

## Examples

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.8 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| kubernetes_cluster_role.datadog_agent | resource |
| kubernetes_cluster_role_binding_v1.datadog_agent | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_namespaces"></a> [custom\_namespaces](#input\_custom\_namespaces) | Custom namespaces to be created during initialization | `list(string)` | `[]` | no |
| <a name="input_datadog_agent_cluster_role_name"></a> [datadog\_agent\_cluster\_role\_name](#input\_datadog\_agent\_cluster\_role\_name) | n/a | `string` | `"datadog-agent"` | no |
| <a name="input_default_service_account"></a> [default\_service\_account](#input\_default\_service\_account) | Default service account name for binding with Datadog | `string` | `"default"` | no |
| <a name="input_fargate_profiles"></a> [fargate\_profiles](#input\_fargate\_profiles) | Configuration block(s) for selecting Kubernetes Pods to execute with this Fargate Profile | `any` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
