# Static website module

Module which create a static website on AWS.

This module will create the components below:

- S3 bucket
- Cloudfront Distribution

## Usage

### Create a static website

```hcl
module "static_website" {
  source = "github.com/spartan-stratos/terraform-modules//aws/static-website?ref=v0.1.0"

  name              = "example"
  enabled_create_s3 = true
  dns_name          = "example"
  route53_zone_id   = "<r53_zone_id>"

  global_tls_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-efgh-5678-ijkl-9012mnopqrst"
}
```

## Examples

- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->

# Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 5.75  |

## Providers

| Name                                              | Version |
|---------------------------------------------------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.75 |

## Modules

| Name                                                               | Source               | Version |
|--------------------------------------------------------------------|----------------------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ./modules/cloudfront | n/a     |
| <a name="module_s3"></a> [s3](#module\_s3)                         | ../s3                | n/a     |

## Resources

| Name                                                                                                           | Type        |
|----------------------------------------------------------------------------------------------------------------|-------------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name                                                                                                                   | Description                                                                                    | Type     | Default               | Required |
|------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|----------|-----------------------|:--------:|
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name)                                                           | The DNS name for the static website                                                            | `string` | n/a                   |   yes    |
| <a name="input_enabled_create_s3"></a> [enabled\_create\_s3](#input\_enabled\_create\_s3)                              | The bool value determining whether to create a new S3 bucket                                   | `bool`   | n/a                   |   yes    |
| <a name="input_global_tls_certificate_arn"></a> [global\_tls\_certificate\_arn](#input\_global\_tls\_certificate\_arn) | The TLS certificate arn for the root domain name                                               | `string` | n/a                   |   yes    |
| <a name="input_minimum_protocol_version"></a> [minimum\_protocol\_version](#input\_minimum\_protocol\_version)         | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. | `string` | `"TLSv1.2_2021"`      |    no    |
| <a name="input_name"></a> [name](#input\_name)                                                                         | For creating or retrieving the bucket and cloudfront name                                      | `string` | n/a                   |   yes    |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class)                                                  | The price class for this distribution.                                                         | `string` | `"PriceClass_100"`    |    no    |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id)                                    | R53 zone ID                                                                                    | `string` | n/a                   |   yes    |
| <a name="input_viewer_protocol_policy"></a> [viewer\_protocol\_policy](#input\_viewer\_protocol\_policy)               | Determines the protocols that viewers can use to access your CloudFront distribution.          | `string` | `"redirect-to-https"` |    no    |

## Outputs

| Name                                                                            | Description                                   |
|---------------------------------------------------------------------------------|-----------------------------------------------|
| <a name="output_cloudfront_id"></a> [cloudfront\_id](#output\_cloudfront\_id)   | The Cloudfront ID that hosting the web        |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name)         | The domain name of the site                   |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The S3 bucket arn that holding the web assets |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id)    | The S3 bucket ID that holding the web assets  |
