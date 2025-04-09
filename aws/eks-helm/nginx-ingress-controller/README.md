# EKS-Helm/NginxIngressController

This module helps install and configure Nginx Ingress Controller for EKS cluster via Helm chart.

## Usage

### Install Keycloak

```hcl
module "eks_helm_keycloak" {
  source = "github.com/spartan-stratos/terraform-modules//aws/eks-helm/nginx-ingress-controller?ref=v0.3.10"

  network_cidr = "10.1.0.0/16"

  nginx_cpu    = "100m"
  nginx_memory = "90Mi"

  replicas    = 1
  minReplicas = 1
  maxReplicas = 3

  ingress_group_name = "external"
  ingress_class_name = "alb"
}
```

## Examples

- [Example](./examples/complete)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                         | Version   |
|------------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)    | >= 1.9.8  |
| <a name="requirement_helm"></a> [helm](#requirement\_helm)                   | >=2.16.1  |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33.0 |

## Providers

| Name                                                                   | Version   |
|------------------------------------------------------------------------|-----------|
| <a name="provider_helm"></a> [helm](#provider\_helm)                   | >=2.16.1  |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.33.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                 | Type        |
|--------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                            | resource    |
| [kubernetes_ingress_v1.nginx_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource    |
| [kubernetes_service.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service)             | data source |

## Inputs

| Name                                                                                                                 | Description                                                                                                                                          | Type     | Default           | Required |
|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|----------|-------------------|:--------:|
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace)                                 | Determines whether a new namespace should be created. Set to 'true' to create the namespace; otherwise, set to 'false' to use an existing namespace. | `bool`   | `true`            |    no    |
| <a name="input_enabled_admission_webhooks"></a> [enabled\_admission\_webhooks](#input\_enabled\_admission\_webhooks) | Enable admission webhooks                                                                                                                            | `bool`   | `false`           |    no    |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version)                         | The chart version of ingress controller                                                                                                              | `string` | `"4.12.1"`        |    no    |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name)                            | The Helm release of the services.                                                                                                                    | `string` | `"ingress-nginx"` |    no    |
| <a name="input_ingress_class_name"></a> [ingress\_class\_name](#input\_ingress\_class\_name)                         | The ingress class name of Neo4j ingress                                                                                                              | `string` | `"alb"`           |    no    |
| <a name="input_ingress_group_name"></a> [ingress\_group\_name](#input\_ingress\_group\_name)                         | The ingress group name of Neo4j ingress                                                                                                              | `string` | `"external"`      |    no    |
| <a name="input_maxReplicas"></a> [maxReplicas](#input\_maxReplicas)                                                  | Max number of pods.                                                                                                                                  | `number` | `3`               |    no    |
| <a name="input_minReplicas"></a> [minReplicas](#input\_minReplicas)                                                  | Min numer of pods.                                                                                                                                   | `number` | `1`               |    no    |
| <a name="input_namespace"></a> [namespace](#input\_namespace)                                                        | The Namespace of the services.                                                                                                                       | `string` | `"kube-system"`   |    no    |
| <a name="input_network_cidr"></a> [network\_cidr](#input\_network\_cidr)                                             | Internal network CIDR for forwarding real IPs through Nginx                                                                                          | `string` | n/a               |   yes    |
| <a name="input_nginx_cpu"></a> [nginx\_cpu](#input\_nginx\_cpu)                                                      | The nginx cpu                                                                                                                                        | `string` | `"100m"`          |    no    |
| <a name="input_nginx_memory"></a> [nginx\_memory](#input\_nginx\_memory)                                             | The nginx memory                                                                                                                                     | `string` | `"90Mi"`          |    no    |
| <a name="input_replicas"></a> [replicas](#input\_replicas)                                                           | Number of pods.                                                                                                                                      | `number` | `1`               |    no    |

## Outputs

| Name                                                                                                                                    | Description |
|-----------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a name="output_ingress_controller_namespace"></a> [ingress\_controller\_namespace](#output\_ingress\_controller\_namespace)            | n/a         |
| <a name="output_ingress_controller_service_name"></a> [ingress\_controller\_service\_name](#output\_ingress\_controller\_service\_name) | n/a         |
