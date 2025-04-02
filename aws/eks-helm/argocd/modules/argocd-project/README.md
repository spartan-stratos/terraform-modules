<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
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
| [kubernetes_manifest.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.repo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | Namespace of Argo CD | `string` | `"argocd"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the Argo CD project | `string` | n/a | yes |
| <a name="input_enabled_custom_github_app"></a> [enabled\_custom\_github\_app](#input\_enabled\_custom\_github\_app) | Enable custom GitHub App configuration | `bool` | `false` | no |
| <a name="input_github_app"></a> [github\_app](#input\_github\_app) | GitHub App configuration to use for Argo CD | <pre>object({<br/>    name            = string<br/>    app_id          = number<br/>    installation_id = number<br/>    private_key     = string<br/>    organization    = string<br/>  })</pre> | n/a | yes |
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | GitHub repositories | `set(string)` | n/a | yes |
| <a name="input_group_roles"></a> [group\_roles](#input\_group\_roles) | The project group roles define permissions in the format: 'applications, {roles}, {target-project}, allow'.<br/>- 'applications' specifies the scope (e.g., 'applications' or a specific app).<br/>- '{roles}' can be specific roles (e.g., 'admin', 'viewer') or '*' for all roles.<br/>- '{target-project}' specifies the target project (e.g., 'spartan-iaas-p0001') or '*' for all projects.<br/>- 'allow' indicates the permission type (currently only 'allow' is supported).<br/><br/>Example:<br/>  "spartan-P00001-iaas" = ["applications, *, *, allow",]<br/>  "spartan-P00001-member"  = [<br/>      "applications, *, spartan-eks-dev/*, allow"<br/>      "applications, get, *, allow"<br/>    ] | `map(list(string))` | `{}` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the Argo CD project | `string` | n/a | yes |
| <a name="input_restrict_destinations"></a> [restrict\_destinations](#input\_restrict\_destinations) | Applicable destinations | <pre>list(object({<br/>    server    = string<br/>    namespace = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "namespace": "*",<br/>    "server": "*"<br/>  }<br/>]</pre> | no |
| <a name="input_restrict_source_repos"></a> [restrict\_source\_repos](#input\_restrict\_source\_repos) | Applicable source repositories | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->