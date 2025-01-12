# AWS EKS Terraform module

Terraform module which creates Amazon EKS (Kubernetes) resources

This module will create the components below

- Default system applications like: coredns, metrics-server,
  aws-load-balancer-controller, nginx-ingress-controller
- Associated IAM components for running the cluster
- Default nodes and Fargate profile for running pods
- EFS system for mounting volumes

## Usage

### Create EKS cluster

```hcl
module "eks" {
  source  = "github.com/spartan-stratos/terraform-modules//aws/eks-cluster?ref=v0.1.0"

  region          = "us-west-2"
  environment     = "test"
  cluster_version = "1.28"
  name            = "example"

  # networking
  security_group_ids = []
  vpc_id             = "vpc-123456"
  vpc_cidr           = "0.0.0.0/0"
  public_subnet_ids  = ["subnet-abcde012"]
  private_subnet_ids = ["subnet-abcde014"]

  # feature flags
  enabled_cluster_log_types  = []
  enabled_cloudwatch_logging = false
  create_fargate_profile     = true
  enabled_datadog_agent      = true
  enabled_efs                = true

  # fargate
  fargate_profiles = {
    default = {
      selectors = [
        {
          namespace = "*"
        }
      ]
    }
  }
  fargate_timeouts = {
    create = "20m"
    delete = "20m"
  }
  custom_namespaces         = ["jenkins", "datadog", "service-bot"]
  k8s_core_dns_compute_type = "fargate"

  # custom RBAC
  administrator_role_arn = null
  aws_auth_users         = []
}
```

## Examples

- [Example Fargate](./examples/fargate/)
- [Example Managed nodes](./examples/managed-nodes/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.75 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.33.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_logging"></a> [cloudwatch\_logging](#module\_cloudwatch\_logging) | ./modules/cloudwatch-logging | n/a |
| <a name="module_datadog_rbac"></a> [datadog\_rbac](#module\_datadog\_rbac) | ./modules/datadog-rbac | n/a |
| <a name="module_efs"></a> [efs](#module\_efs) | ./modules/efs | n/a |
| <a name="module_fargate_profile"></a> [fargate\_profile](#module\_fargate\_profile) | ./modules/fargate-profile | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.coredns_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.coredns_fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_group.eks_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy.eks_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_instance_profile.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.custom_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.k8s_masters](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.auth_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.eks_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.master_policy_attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node_policy_attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [kubernetes_config_map_v1_data.aws_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |
| [kubernetes_namespace.fargate](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_addon_version.coredns_latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_eks_addon_version.kube_proxy_latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_eks_addon_version.vpc_cni_latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.auth_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.custom_worker_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.k8s_masters_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.node_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.users_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_role_arn"></a> [administrator\_role\_arn](#input\_administrator\_role\_arn) | AWS Administrator role arn for mapping with K8s RBAC | `string` | `null` | no |
| <a name="input_aws_auth_accounts"></a> [aws\_auth\_accounts](#input\_aws\_auth\_accounts) | AWS accounts for authenticating with Kubernetes | `list(any)` | `[]` | no |
| <a name="input_aws_auth_users"></a> [aws\_auth\_users](#input\_aws\_auth\_users) | AWS users for authenticating with Kubernetes | `list(any)` | `[]` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | The Kubernetes version for creating the cluster. | `string` | `"1.31"` | no |
| <a name="input_create_fargate_profile"></a> [create\_fargate\_profile](#input\_create\_fargate\_profile) | Specify whether creaing the Fargate profile for running pods. | `bool` | `false` | no |
| <a name="input_custom_namespaces"></a> [custom\_namespaces](#input\_custom\_namespaces) | Custom namespaces to be created during initialization | `list(string)` | `[]` | no |
| <a name="input_datadog_agent_cluster_role_name"></a> [datadog\_agent\_cluster\_role\_name](#input\_datadog\_agent\_cluster\_role\_name) | Name of the ClusterRole to create in order to configure Datadog Agents | `string` | `"datadog-agent"` | no |
| <a name="input_default_service_account"></a> [default\_service\_account](#input\_default\_service\_account) | Default service account name for binding with Datadog | `string` | `"default"` | no |
| <a name="input_efs_backup_policy_status"></a> [efs\_backup\_policy\_status](#input\_efs\_backup\_policy\_status) | Enable/disable backup for EFS Filesystem.  Value should be ENABLE/DISABLED.  Defaults to DISABLED | `string` | `"DISABLED"` | no |
| <a name="input_efs_filesystem_name"></a> [efs\_filesystem\_name](#input\_efs\_filesystem\_name) | To specify the name of efs filesystem in case overwrite the default one | `string` | `null` | no |
| <a name="input_efs_lifecycle_policy"></a> [efs\_lifecycle\_policy](#input\_efs\_lifecycle\_policy) | Lifecycle Policy for the EFS Filesystem | <pre>list(object({<br/>    transition_to_ia                    = string<br/>    transition_to_primary_storage_class = string<br/>  }))</pre> | `[]` | no |
| <a name="input_efs_storage_class_name"></a> [efs\_storage\_class\_name](#input\_efs\_storage\_class\_name) | n/a | `string` | `"efs"` | no |
| <a name="input_enabled_cloudwatch_logging"></a> [enabled\_cloudwatch\_logging](#input\_enabled\_cloudwatch\_logging) | Enable logging for Kubernetes Pods through built in EKS Fargate Firelens | `bool` | `false` | no |
| <a name="input_enabled_cluster_log_types"></a> [enabled\_cluster\_log\_types](#input\_enabled\_cluster\_log\_types) | Enabled logging types for EKS Control Plane | `list(string)` | <pre>[<br/>  "api",<br/>  "audit",<br/>  "authenticator",<br/>  "controllerManager",<br/>  "scheduler"<br/>]</pre> | no |
| <a name="input_enabled_datadog_agent"></a> [enabled\_datadog\_agent](#input\_enabled\_datadog\_agent) | Enable datadog integration RBAC creation | `bool` | `false` | no |
| <a name="input_enabled_efs"></a> [enabled\_efs](#input\_enabled\_efs) | Enable EFS creation for persistence volumes | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name, will be used in components's name. | `string` | n/a | yes |
| <a name="input_fargate_profiles"></a> [fargate\_profiles](#input\_fargate\_profiles) | Configuration block(s) for selecting Kubernetes Pods to execute with this Fargate Profile | `any` | `{}` | no |
| <a name="input_fargate_timeouts"></a> [fargate\_timeouts](#input\_fargate\_timeouts) | Default timeout attributes. | <pre>object({<br/>    create = string<br/>    delete = string<br/>  })</pre> | <pre>{<br/>  "create": "20m",<br/>  "delete": "20m"<br/>}</pre> | no |
| <a name="input_filesystem_encrypted"></a> [filesystem\_encrypted](#input\_filesystem\_encrypted) | Enable encryption for EFS | `bool` | `true` | no |
| <a name="input_filesystem_performance_mode"></a> [filesystem\_performance\_mode](#input\_filesystem\_performance\_mode) | The file system performance mode. | `string` | `"generalPurpose"` | no |
| <a name="input_filesystem_throughput_mode"></a> [filesystem\_throughput\_mode](#input\_filesystem\_throughput\_mode) | Throughput mode for the file system. | `string` | `"bursting"` | no |
| <a name="input_k8s_core_dns_compute_type"></a> [k8s\_core\_dns\_compute\_type](#input\_k8s\_core\_dns\_compute\_type) | The compute type for the core DNS | `string` | `"ec2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The prefix name that will be used in cluster and components's name. | `string` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | Key-value mapping of Kubernetes node groups attributes | `any` | `{}` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | The private subnet IDs in the associated VPC | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | The public subnet IDs in the associated VPC | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region of the EKS cluster. | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs that will be used in additional to the default ones. | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR for creating default security groups | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the cluster will be created on. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_eks_cluster"></a> [aws\_eks\_cluster](#output\_aws\_eks\_cluster) | The EKS cluster master details, including API server endpoint and certificate authority |
| <a name="output_aws_eks_cluster_auth_data"></a> [aws\_eks\_cluster\_auth\_data](#output\_aws\_eks\_cluster\_auth\_data) | The ConfigMap data for managing EKS cluster authentication |
| <a name="output_aws_iam_instance_profile_node"></a> [aws\_iam\_instance\_profile\_node](#output\_aws\_iam\_instance\_profile\_node) | The instance profile associated with the EKS worker nodes |
| <a name="output_aws_iam_role_node"></a> [aws\_iam\_role\_node](#output\_aws\_iam\_role\_node) | The IAM role assigned to the EKS worker nodes for managing permissions |
| <a name="output_aws_security_group_cluster"></a> [aws\_security\_group\_cluster](#output\_aws\_security\_group\_cluster) | The security group applied to the EKS cluster for network control |
| <a name="output_datadog_agent_cluster_role_name"></a> [datadog\_agent\_cluster\_role\_name](#output\_datadog\_agent\_cluster\_role\_name) | Name of the ClusterRole to create in order to configure Datadog Agents |
| <a name="output_efs"></a> [efs](#output\_efs) | The Amazon EFS (Elastic File System) configuration for the cluster, if available |
| <a name="output_eks_default_auth_role_arn"></a> [eks\_default\_auth\_role\_arn](#output\_eks\_default\_auth\_role\_arn) | The ARN of the IAM role used for default EKS authentication |
| <a name="output_fargate_profile"></a> [fargate\_profile](#output\_fargate\_profile) | Details of the Fargate profile configured for the EKS cluster |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | The OpenID Connect (OIDC) provider associated with the EKS cluster for IAM roles |
<!-- END_TF_DOCS -->