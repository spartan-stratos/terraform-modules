<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.repo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | Namespace of Argo CD | `string` | `"argocd"` | no |
| <a name="input_enabled_custom_github_app"></a> [enabled\_custom\_github\_app](#input\_enabled\_custom\_github\_app) | Enable custom GitHub App configuration | `bool` | `false` | no |
| <a name="input_github_app"></a> [github\_app](#input\_github\_app) | GitHub App configuration to use for Argo CD | <pre>object({<br/>    name            = string<br/>    app_id          = number<br/>    installation_id = number<br/>    private_key     = string<br/>    organization    = string<br/>  })</pre> | n/a | yes |
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | GitHub repositories | `set(string)` | n/a | yes |
| <a name="input_group_roles"></a> [group\_roles](#input\_group\_roles) | The project group roles define permissions in the format: 'applications, {roles}, {target-project}, allow'.<br/>- 'applications' specifies the scope (e.g., 'applications' or a specific app).<br/>- '{roles}' can be specific roles (e.g., 'admin', 'viewer') or '*' for all roles.<br/>- '{target-project}' specifies the target project (e.g., 'spartan-iaas-p0001') or '*' for all projects.<br/>- 'allow' indicates the permission type (currently only 'allow' is supported).<br/><br/>Example:<br/>  "spartan-P00001-iaas" = ["applications, *, *, allow",]<br/>  "spartan-P00001-member"  = [<br/>      "applications, *, spartan-eks-dev/*, allow"<br/>      "applications, get, *, allow"<br/>    ] | `map(list(string))` | `{}` | no |
| <a name="input_projects"></a> [projects](#input\_projects) | n/a | <pre>map(object({<br/>    project_name = string<br/>    description  = string<br/>    destinations = list(object({<br/>      name      = optional(string, null)<br/>      server    = optional(string, null)<br/>      namespace = string<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | ArgoCD Centralized Repository | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->