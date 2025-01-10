# Vanta module

This module will create the components below:

- IAM role for Vanta Auditor
- IAM policy for Vanta permissions

## Usage

### Create a Vanta Module

```hcl
module "vanta" {
  source = "github.com/spartan-stratos/terraform-modules//aws/vanta?ref=v0.1.49"

  providers = {
    aws.global = aws.global
  }
}
```

## Examples

- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.75 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.vanta_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.vanta_auditor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.vanta_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vanta_security_audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vanta_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vanta_role"></a> [vanta\_role](#input\_vanta\_role) | The ID of the Vanta role used for managing access and permissions in the environment. | `string` | `"956993596390"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vanta_auditor_arn"></a> [vanta\_auditor\_arn](#output\_vanta\_auditor\_arn) | The arn from the Terraform created role that you need to input into the Vanta UI at the end of the AWS connection steps. |
<!-- END_TF_DOCS -->