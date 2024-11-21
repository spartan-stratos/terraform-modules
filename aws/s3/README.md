# AWS S3 Terraform module

Terraform module which creates S3 resources on AWS.

This module will create:

- S3 bucket with alongside configuration and policy
- Two IAM policy for reading and writing to the bucket objects

## Usage

### Create S3

```hcl
module "s3" {
  source  = github.com/spartan-stratos/terraform-modules//aws/s3?ref=v0.1.0"

  bucket_name     = "example-bucket"
  allowed_origins = ["example.com"]
}
```

## Examples

- [Example](./examples/complete/)

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | ~> 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 5.75  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 5.75 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_policy.readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                   | resource    |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                       | resource    |
| [aws_s3_bucket.with_prefix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                  | resource    |
| [aws_s3_bucket.without_prefix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                               | resource    |
| [aws_s3_bucket_cors_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration)   | resource    |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls)   | resource    |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource    |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                   | resource    |
| [aws_iam_policy_document.readonly_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)       | data source |
| [aws_iam_policy_document.this_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)           | data source |

## Inputs

| Name                                                                                                   | Description                                                                               | Type                                                                                                                                                                                 | Default                                                                                                                        | Required |
| ------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | :------: |
| <a name="input_block_public_acls"></a> [block_public_acls](#input_block_public_acls)                   | Whether Amazon S3 should block public ACLs for this bucket.                               | `bool`                                                                                                                                                                               | `true`                                                                                                                         |    no    |
| <a name="input_block_public_policy"></a> [block_public_policy](#input_block_public_policy)             | Whether Amazon S3 should block public bucket policies for this bucket.                    | `bool`                                                                                                                                                                               | `true`                                                                                                                         |    no    |
| <a name="input_bucket_name"></a> [bucket_name](#input_bucket_name)                                     | The bucket name to be created.                                                            | `string`                                                                                                                                                                             | `null`                                                                                                                         |    no    |
| <a name="input_bucket_prefix"></a> [bucket_prefix](#input_bucket_prefix)                               | The bucket prefix to be created.                                                          | `string`                                                                                                                                                                             | `null`                                                                                                                         |    no    |
| <a name="input_cors_configuration"></a> [cors_configuration](#input_cors_configuration)                | Configuration for CORS settings                                                           | <pre>object({<br> allowed_headers = optional(list(string))<br> allowed_methods = list(string)<br> allowed_origins = list(string)<br> max_age_seconds = optional(number)<br> })</pre> | <pre>{<br> "allowed_headers": [],<br> "allowed_methods": [],<br> "allowed_origins": [],<br> "max_age_seconds": 3600<br>}</pre> |    no    |
| <a name="input_enabled_cors"></a> [enabled_cors](#input_enabled_cors)                                  | Enable to configure the CORS                                                              | `bool`                                                                                                                                                                               | `false`                                                                                                                        |    no    |
| <a name="input_enabled_iam_policy"></a> [enabled_iam_policy](#input_enabled_iam_policy)                | Enabled create the IAM Policies.                                                          | `bool`                                                                                                                                                                               | `false`                                                                                                                        |    no    |
| <a name="input_force_destroy"></a> [force_destroy](#input_force_destroy)                               | Enable to force destroy the bucket.                                                       | `bool`                                                                                                                                                                               | `false`                                                                                                                        |    no    |
| <a name="input_ignore_public_acls"></a> [ignore_public_acls](#input_ignore_public_acls)                | Whether Amazon S3 should ignore public ACLs for this bucket.                              | `bool`                                                                                                                                                                               | `true`                                                                                                                         |    no    |
| <a name="input_object_ownership"></a> [object_ownership](#input_object_ownership)                      | Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced | `string`                                                                                                                                                                             | `null`                                                                                                                         |    no    |
| <a name="input_restrict_public_buckets"></a> [restrict_public_buckets](#input_restrict_public_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket.                 | `bool`                                                                                                                                                                               | `true`                                                                                                                         |    no    |
| <a name="input_versioning_status"></a> [versioning_status](#input_versioning_status)                   | The status of bucket versioning.                                                          | `string`                                                                                                                                                                             | `"Disabled"`                                                                                                                   |    no    |

## Outputs

| Name                                                                                                                                                                    | Description                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| <a name="output_iam_policy_s3_bucket_assets_read_only_arn"></a> [iam_policy_s3_bucket_assets_read_only_arn](#output_iam_policy_s3_bucket_assets_read_only_arn)          | The ARN of the IAM policy granting read-only access to the S3 bucket assets |
| <a name="output_iam_policy_s3_bucket_public_assets_write_arn"></a> [iam_policy_s3_bucket_public_assets_write_arn](#output_iam_policy_s3_bucket_public_assets_write_arn) | The ARN of the IAM policy granting write access to public assets            |
| <a name="output_s3_bucket_arn"></a> [s3_bucket_arn](#output_s3_bucket_arn)                                                                                              | The ARN of the S3 bucket                                                    |
| <a name="output_s3_bucket_id"></a> [s3_bucket_id](#output_s3_bucket_id)                                                                                                 | The unique ID of the S3 bucket                                              |
| <a name="output_s3_bucket_name"></a> [s3_bucket_name](#output_s3_bucket_name)                                                                                           | The name of the S3 bucket                                                   |
| <a name="output_s3_bucket_regional_domain_name"></a> [s3_bucket_regional_domain_name](#output_s3_bucket_regional_domain_name)                                           | The regional dothis name of the S3 bucket                                   |
