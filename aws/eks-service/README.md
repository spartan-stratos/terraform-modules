# EKS Service
This module helps configure an 'EKS Service' by creating a correlation set of  [Kubernetes and AWS resources](#resources).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.33 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [kubernetes_annotations.default](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/annotations) | resource |
| [kubernetes_config_map.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [aws_lb_hosted_zone_id.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_hosted_zone_id) | data source |
| [kubernetes_namespace_v1.existing](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/namespace_v1) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_dns"></a> [alb\_dns](#input\_alb\_dns) | The DNS of the ALB from K8s cluster | `any` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS Cluster name | `string` | n/a | yes |
| <a name="input_eks_oidc_provider"></a> [eks\_oidc\_provider](#input\_eks\_oidc\_provider) | The OIDC provider of the EKS cluster | <pre>object({<br/>    arn = string<br/>    url = string<br/>  })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region for getting ALB hosted zone ID | `any` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | The zone id for adding hostnames for services | `any` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Mapping of service name, namespace and their secrets | <pre>object({<br/>    name                       = string<br/>    additional_iam_policy_arns = optional(list(string), [])<br/>    config_map                 = optional(map(any), {})<br/>    hostnames                  = list(string)<br/>    namespace                  = string<br/>    secrets                    = optional(map(any), {})<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pod_role"></a> [pod\_role](#output\_pod\_role) | n/a |
<!-- END_TF_DOCS -->
