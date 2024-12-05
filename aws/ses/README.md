# AWS SES Terraform module
Terraform module which creates SES resources on AWS.

This module will create the following components:
- SES
- (Optional) Route53 record to verify SES domain

## Usage
### Create SES
```hcl
module "ses" {
  source  = "github.com/spartan-stratos/terraform-modules//aws/ses?ref=v0.1.3"

  email_domain = "example.com"

  emails = ["abc@example.com", "xyz@example.com"]

  principal_roles = ["arn:aws:iam::<account-id>:role/ses-role"]
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
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_record.verification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ses_domain_identity_verification.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_ses_identity_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_identity_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|----------------|------------|:--------:|
| <a name="input_email_domain"></a> [email\_domain](#input\_email\_domain)| The domain name for which SES will be configured (e.g., 'example.com'). | `string` | n/a | yes |
| <a name="input_emails"></a> [emails](#input\_emails) | List of email addresses allowed for sending in SES sandbox mode. These are verified to send emails during testing. | `list(string)` | `null` | no |
| <a name="input_principal_roles"></a> [principal\_roles](#input\_principal\_roles) | Specifies whether message deduplication occurs at the message group or queue level. (perQueue or perMessageGroupId) | `list(string)` |`null`| no |
| <a name="input_record_type"></a> [record\_type](#input\_record\_type) | The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. | `string` |`TXT`| no |
| <a name="input_record_ttl"></a> [record\_ttl](#input\_record\_ttl) | The TTL of the record. | `number` |`600`| no |
| <a name="input_use_route53"></a> [use\_route53](#input\_use\_route53) | To enable route53 record to verify email domain | `bool` |`false`| no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the SES domain identity for the email domain |
<!-- END_TF_DOCS -->