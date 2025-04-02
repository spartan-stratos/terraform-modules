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
| [kubernetes_manifest.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_applications"></a> [applications](#input\_applications) | Maps of application configuration which will point to, each application will represent for a service on a envinronment | <pre>map(object({<br/>    name                     = string<br/>    environment              = string<br/>    project_name             = string<br/>    destination_cluster_name = string<br/>    namespace                = string<br/>    repo_url                 = string<br/>  }))</pre> | `{}` | no |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | Namespace to install Argo CD | `string` | `"argocd"` | no |
| <a name="input_sync_policy"></a> [sync\_policy](#input\_sync\_policy) | value | <pre>object({<br/>    automated = object({<br/>      prune    = bool<br/>      selfHeal = bool<br/>    })<br/><br/>    syncOptions = list(string)<br/><br/>    retry = object({<br/>      limit = number<br/>    })<br/>  })</pre> | <pre>{<br/>  "automated": {<br/>    "prune": true,<br/>    "selfHeal": true<br/>  },<br/>  "retry": {<br/>    "limit": 5<br/>  },<br/>  "syncOptions": [<br/>    "CreateNamespace=true",<br/>    "Retry=true"<br/>  ]<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->