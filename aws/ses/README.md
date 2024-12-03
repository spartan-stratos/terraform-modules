# AWS SES Terraform module
Terraform module which creates SES resources on AWS.

This module will create the following components:
- A main queue for receiving messages
- A dead letter queue for storing un-processed messages

## Usage
### Create SES
```hcl
module "ses" {
  source  = "github.com/spartan-stratos/terraform-modules//aws/ses?ref=v0.1.0"

  name              = "example-ses"
  email_domain      = "example.com"
  principal_roles   = ["arn:aws:iam::<account-id>:role/ses-role"]
}
```

## Examples
- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version  |
|------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | \>= 5.75 |

## Providers

| Name | Version  |
|------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | \>= 5.75 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ses_domain_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_email_identity.emails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_email_identity) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Inputs

| Name                                                                                                                 | Description                                                                                                                        | Type           | Default    | Required |
|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|----------------|------------|:--------:|
| <a name="email_domain"></a> [email\_domain](#email\_domain)                                          | The domain name for which SES will be configured (e.g., 'example.com').                       | `string`       | `n\a`      |    yes    |
| <a name="emails"></a> [emails](#emails)                | List of email addresses allowed for sending in SES sandbox mode. These are verified to send emails during testing.          | `list(string)`       | `null` |    no    |
| <a name="principal_roles"></a> [principal\_roles](#principal\_roles)       | Specifies whether message deduplication occurs at the message group or queue level. (perQueue or perMessageGroupId)                | `list(string)`       | `null`     |    no    |

## Outputs

| Name | Description |
|------|-------------|
| <a name="arn"></a> [arn](#output\_arn) | The ARN of the SES domain identity for the email domain |
<!-- END_TF_DOCS -->