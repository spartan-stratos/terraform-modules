<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.16.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.75.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.16.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.33 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_load_balancer_controller_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_ingress_v1.external_alb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_ingress_v1.internal_alb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [time_sleep.wait_for_aws_load_balancer_webhook_is_running](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_iam_policy_document.aws_load_balancer_controller_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_load_balancer_controller_chart_version"></a> [aws\_load\_balancer\_controller\_chart\_version](#input\_aws\_load\_balancer\_controller\_chart\_version) | Helm chart version of AWS load balancer controller | `string` | `"1.9.2"` | no |
| <a name="input_aws_load_balancer_controller_name"></a> [aws\_load\_balancer\_controller\_name](#input\_aws\_load\_balancer\_controller\_name) | Name of AWS load balancer controller name | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | Certificate arn for aws load balancer controller | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS Cluster name | `string` | n/a | yes |
| <a name="input_enable_internal_alb"></a> [enable\_internal\_alb](#input\_enable\_internal\_alb) | Enable internal aws load balancer | `bool` | `false` | no |
| <a name="input_external_group_name"></a> [external\_group\_name](#input\_external\_group\_name) | Group name of external aws load balancer | `string` | `"external"` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | The idle timeout of load balancer. | `string` | `"60"` | no |
| <a name="input_ingress_controller_service_name"></a> [ingress\_controller\_service\_name](#input\_ingress\_controller\_service\_name) | Service name of nginx ingress controller | `string` | `"ingress-nginx-controller"` | no |
| <a name="input_internal_group_name"></a> [internal\_group\_name](#input\_internal\_group\_name) | Group name of internal aws load balancer | `string` | `"internal"` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Namespace of ingress controller | `string` | `"alb"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace of the aws load balancer | `string` | `"kube-system"` | no |
| <a name="input_oidc_provider"></a> [oidc\_provider](#input\_oidc\_provider) | The OIDC provider which are realted to the cluster. | <pre>object({<br/>    arn = string<br/>    url = string<br/>  })</pre> | n/a | yes |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | List private subnet of cluster for creating aws internal load balancer | `list(string)` | n/a | yes |
| <a name="input_public_subnet"></a> [public\_subnet](#input\_public\_subnet) | List public subnet of cluster for creating aws external load balancer | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where the resources will be created. | `string` | n/a | yes |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | SSL policy for AWS Load Balancer | `string` | `"ELBSecurityPolicy-TLS13-1-2-2021-06"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC that the resources reside in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_alb_cname"></a> [external\_alb\_cname](#output\_external\_alb\_cname) | CNAME address of external aws load balancer |
| <a name="output_external_group_name"></a> [external\_group\_name](#output\_external\_group\_name) | Group name of external aws load balancer |
| <a name="output_internal_alb_cname"></a> [internal\_alb\_cname](#output\_internal\_alb\_cname) | CNAME address of internal aws load balancer |
| <a name="output_internal_group_name"></a> [internal\_group\_name](#output\_internal\_group\_name) | Group name of internal aws load balancer |
<!-- END_TF_DOCS -->