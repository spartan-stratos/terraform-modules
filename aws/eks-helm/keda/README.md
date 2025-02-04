# AWS EKS Keda Helm Chart Deployment Terraform Module

This Terraform module is used to deploy the Keda Helm chart on an AWS EKS cluster.

## Usage

### Create a Keda Helm Chart Deployment

```hcl
module "keda" {
  source = "github.com/spartan-stratos/terraform-modules//aws/eks-helm/keda?ref=v0.1.60"

  oidc_provider = {
    url = "arn:aws:iam::000000000000:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/14BAEE13AC4C24FC396BE87C8DF5XXXX"
    arn = "oidc.eks.us-west-2.amazonaws.com/id/14BAEE13AC4C24FC396BE87C8DF5XXXX"
  }
}

```

## Examples

- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8  |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 5.75.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm)                | >=2.16.1  |

## Providers

| Name                                                 | Version   |
|------------------------------------------------------|-----------|
| <a name="provider_aws"></a> [aws](#provider\_aws)    | >= 5.75.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.16.1  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                      | Type        |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                 | resource    |
| [aws_iam_role_policy.assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)                     | resource    |
| [helm_release.keda](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                                 | resource    |
| [aws_iam_policy_document.assume-role-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                        | data source |

## Inputs

| Name                                                                                                                                  | Description                                                                       | Type                                                                   | Default           | Required |
|---------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|------------------------------------------------------------------------|-------------------|:--------:|
| <a name="input_admission_webhook_server_cpu"></a> [admission\_webhook\_server\_cpu](#input\_admission\_webhook\_server\_cpu)          | The amount of CPU resources allocated to the admission webhook server.            | `string`                                                               | `"50m"`           |    no    |
| <a name="input_admission_webhook_server_memory"></a> [admission\_webhook\_server\_memory](#input\_admission\_webhook\_server\_memory) | The amount of memory resources allocated to the admission webhook server.         | `string`                                                               | `"64Mi"`          |    no    |
| <a name="input_assume_role_arns"></a> [assume\_role\_arns](#input\_assume\_role\_arns)                                                | A list of ARNs that Keda will use to assume the IAM role to access AWS resources. | `list(string)`                                                         | `[]`              |    no    |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version)                                                           | The version of the Keda Helm chart being deployed.                                | `string`                                                               | `"0.2.0"`         |    no    |
| <a name="input_enabled_aws_irsa"></a> [enabled\_aws\_irsa](#input\_enabled\_aws\_irsa)                                                | Option to enable or disable the AWS IAM Roles for Service Accounts (IRSA).        | `bool`                                                                 | `true`            |    no    |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name)                                             | The name of the Helm release for the Keda deployment.                             | `string`                                                               | `"keda"`          |    no    |
| <a name="input_keda_operator_role_name"></a> [keda\_operator\_role\_name](#input\_keda\_operator\_role\_name)                         | The name of the IAM role that Keda will use to access AWS resources.              | `string`                                                               | `"keda-operator"` |    no    |
| <a name="input_metric_server_cpu"></a> [metric\_server\_cpu](#input\_metric\_server\_cpu)                                             | The amount of CPU resources allocated to the metric server.                       | `string`                                                               | `"50m"`           |    no    |
| <a name="input_metric_server_memory"></a> [metric\_server\_memory](#input\_metric\_server\_memory)                                    | The amount of memory resources allocated to the metric server.                    | `string`                                                               | `"64Mi"`          |    no    |
| <a name="input_namespace"></a> [namespace](#input\_namespace)                                                                         | The Kubernetes namespace where Keda will be installed. Defaults to 'keda'.        | `string`                                                               | `"keda"`          |    no    |
| <a name="input_oidc_provider"></a> [oidc\_provider](#input\_oidc\_provider)                                                           | The OIDC provider which are related to the cluster and is used for IRSA.          | <pre>object({<br/>    arn = string<br/>    url = string<br/>  })</pre> | n/a               |   yes    |
| <a name="input_operator_cpu"></a> [operator\_cpu](#input\_operator\_cpu)                                                              | The amount of CPU resources allocated to the operator.                            | `string`                                                               | `"100m"`          |    no    |
| <a name="input_operator_memory"></a> [operator\_memory](#input\_operator\_memory)                                                     | The amount of memory resources allocated to the operator.                         | `string`                                                               | `"256Mi"`         |    no    |

## Outputs

| Name                                                                                                         | Description |
|--------------------------------------------------------------------------------------------------------------|-------------|
| <a name="output_keda_operator_role_arn"></a> [keda\_operator\_role\_arn](#output\_keda\_operator\_role\_arn) | n/a         |

<!-- END_TF_DOCS -->
