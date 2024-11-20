# AWS S3 Terraform module
Terraform module which creates S3 resources on AWS.

This module will create:
- S3 bucket with alongside configuration and policy
- Two IAM policy for reading and writing to the bucket objects

## Usage
### Create SQS
```hcl
module "s3" {
  source  = "c0x12c/s3/aws"
  version = "~> 1.0"

  environment     = "dev"
  bucket_name     = "example-bucket"
  allowed_origins = ["example.com"]
}
```

## Examples
- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.8 |
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
| [aws_iam_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_cors_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_ownership_controls.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.block_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_iam_policy_document.main_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.readonly_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_origins"></a> [allowed\_origins](#input\_allowed\_origins) | Custom allowed origins for the bucket configuration | `list(string)` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The bucket name to be created | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_s3_bucket_assets_read_only_arn"></a> [iam\_policy\_s3\_bucket\_assets\_read\_only\_arn](#output\_iam\_policy\_s3\_bucket\_assets\_read\_only\_arn) | The ARN of the IAM policy granting read-only access to the S3 bucket assets |
| <a name="output_iam_policy_s3_bucket_public_assets_write_arn"></a> [iam\_policy\_s3\_bucket\_public\_assets\_write\_arn](#output\_iam\_policy\_s3\_bucket\_public\_assets\_write\_arn) | The ARN of the IAM policy granting write access to public assets |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The unique ID of the S3 bucket |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | The name of the S3 bucket |
| <a name="output_s3_bucket_regional_domain_name"></a> [s3\_bucket\_regional\_domain\_name](#output\_s3\_bucket\_regional\_domain\_name) | The regional domain name of the S3 bucket |
<!-- END_TF_DOCS -->
