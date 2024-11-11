# Static website module
Module which create a static website on AWS.

This module will create the components below:
- S3 bucket
- Cloudfront Distribution

## Usage
### Create a static website
```hcl
module "static_website" {
  source  = "c0x12c/static-website/aws"
  version = "~> 1.0"

  name        = "example"
  stack_name  = "spartan"
  environment = "dev"

  dns_name          = "example"
  route53_zone_id   = "<r53_zone_id>"
  route53_zone_name = "spartan-dev.io"

  global_tls_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-efgh-5678-ijkl-9012mnopqrst"
}
```

## Examples
- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.46 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | The DNS name for the static website | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | n/a | yes |
| <a name="input_global_tls_certificate_arn"></a> [global\_tls\_certificate\_arn](#input\_global\_tls\_certificate\_arn) | The TLS certificate arn for the root domain name | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | For creating the bucket and cloudfront name | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | R53 zone ID | `string` | n/a | yes |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | R53 zone name | `string` | n/a | yes |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | The stack name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_id"></a> [cloudfront\_id](#output\_cloudfront\_id) | The Cloudfront ID that hosting the web |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The domain name of the site |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The S3 bucket arn that holding the web assets |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The S3 bucket ID that holding the web assets |
<!-- END_TF_DOCS -->
