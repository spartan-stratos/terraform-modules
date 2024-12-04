# AWS KMS Terraform module
Terraform module which creates KMS resources on AWS.

This module will create the following components:
- A KMS key with configurable properties such as description, key usage, key rotation, and a custom policy for encryption and decryption actions.
- An alias for the KMS key, providing a user-friendly name to reference the key in other AWS resources.

## Usage
### Create KMS
```hcl
module "kms" {
  source  = "github.com/spartan-stratos/terraform-modules//aws/kms?ref=v0.1.2"

  name                     = "example"
  description              = "example"
  deletion_window_in_days  = 7
  key_usage                = "ENCRYPT_DECRYPT"
  custom_key_store_id      = null
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = false
  enabled_create_policy    = true
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
| [aws_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|----------------|------------|:--------:|
| <a name="input_name"></a> [name](#input\_name)| The name of the key as viewed in AWS console.| `string`| n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console. | `string` | `null` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | The waiting period, specified in number of days.| `number` | `7` |    no    |
| <a name="input_fifo_enabled"></a> [fifo\_enabled](#input\_fifo\_enabled)| Specify whether enable FIFO or not for the KMS queue.| `bool` | `false` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage)| Specifies the intended use of the key. Valid values: ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC. | `string` | `ENCRYPT_DECRYPT` | no |
| <a name="input_custom_key_store_id"></a> [custom\_key\_store\_id](#input\_custom\_key\_store\_id) | ID of the KMS Custom Key Store where the key will be stored instead of KMS (eg CloudHSM). | `string` | `null` | no |
| <a name="input_customer_master_key_spec"></a> [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. | `string` | `SYMMETRIC_DEFAULT` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled. Required to be enabled if rotation_period_in_days is specified | `bool` | `false` | no |
| <a name="input_rotation_period_in_days"></a> [rotation\_period\_in\_days](#input\_rotation\_period\_in\_days) | Custom period of time between each rotation date. Must be a number between 90 and 2560. | `number` | `90` | no |
| <a name="input_enabled_create_policy"></a> [enabled\_create\_policy](#input\_enabled\_create\_policy) | Specifies whether policy need to be created. | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | The KMS dead letter queue info |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | The KMS queue info |
| <a name="output_key_alias"></a> [key\_alias](#output\_key\_alias) | The KMS dead letter queue info |
| <a name="output_iam_policy_kms_encrypt_decrypt_arn"></a> [iam\_policy\_kms\_encrypt\_decrypt\_arn](#output\_iam\_policy\_kms\_encrypt\_decrypt\_arn) | The KMS queue info |
<!-- END_TF_DOCS -->