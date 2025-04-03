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
| [kubernetes_manifest.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | Namespace of Argo CD | `string` | `"argocd"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS Cluster Name | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | n/a | yes |
| <a name="input_destinations"></a> [destinations](#input\_destinations) | n/a | <pre>list(object({<br/>    name      = optional(string, null)<br/>    server    = optional(string, null)<br/>    namespace = string<br/>  }))</pre> | n/a | yes |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | GitHub Organization | `set(string)` | n/a | yes |
| <a name="input_group_roles"></a> [group\_roles](#input\_group\_roles) | The project group roles define permissions in the format: 'applications, {roles}, {target-project}, allow'.<br/>- 'applications' specifies the scope (e.g., 'applications' or a specific app).<br/>- '{roles}' can be specific roles (e.g., 'admin', 'viewer') or '*' for all roles.<br/>- '{target-project}' specifies the target project (e.g., 'spartan-iaas-p0001') or '*' for all projects.<br/>- 'allow' indicates the permission type (currently only 'allow' is supported).<br/><br/>Example:<br/>  "spartan-P00001-iaas" = ["applications, *, *, allow",]<br/>  "spartan-P00001-member"  = [<br/>      "applications, *, spartan-eks-dev/*, allow"<br/>      "applications, get, *, allow"<br/>    ] | `map(list(string))` | `{}` | no |
| <a name="input_path"></a> [path](#input\_path) | path | `string` | `"dev"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_repo_url"></a> [repo\_url](#input\_repo\_url) | ArgoCD Centralized Repository | `string` | n/a | yes |
| <a name="input_sync_policy"></a> [sync\_policy](#input\_sync\_policy) | value | <pre>object({<br/>    automated = object({<br/>      prune    = bool<br/>      selfHeal = bool<br/>    })<br/><br/>    syncOptions = list(string)<br/><br/>    retry = object({<br/>      limit = number<br/>    })<br/>  })</pre> | <pre>{<br/>  "automated": {<br/>    "prune": true,<br/>    "selfHeal": true<br/>  },<br/>  "retry": {<br/>    "limit": 5<br/>  },<br/>  "syncOptions": [<br/>    "CreateNamespace=true",<br/>    "Retry=true"<br/>  ]<br/>}</pre> | no |
| <a name="input_target_revision"></a> [target\_revision](#input\_target\_revision) | Target Revision for deployment | `string` | `"HEAD"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->