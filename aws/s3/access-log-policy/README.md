# AWS S3 Access Log Policy

Sub module of AWS/S3 to allow AWS Service to write access logs from other sources.

Reference: https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html

## Usage

```hcl
module "access_logs" {
  source                = "github.com/spartan-stratos/terraform-modules//aws/s3/access-log-policy?ref=v0.1.56"
  source_bucket_arns    = ["arn:aws:s3:::my-source-bucket"]
  access_logs_bucket_id = "my-access-logs-bucket"
}
```

## Examples

- [Example](./examples/)


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_policy.s3_server_write_access_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_bucket_arn"></a> [access\_logs\_bucket\_arn](#input\_access\_logs\_bucket\_arn) | The arn of the access logs bucket | `string` | n/a | yes |
| <a name="input_access_logs_bucket_id"></a> [access\_logs\_bucket\_id](#input\_access\_logs\_bucket\_id) | The access logs bucket | `string` | n/a | yes |
| <a name="input_source_bucket_arns"></a> [source\_bucket\_arns](#input\_source\_bucket\_arns) | The source buckets that can write to the access logs bucket | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
