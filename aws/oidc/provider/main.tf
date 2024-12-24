/**
This data source can be used to fetch information about a specific IAM OpenID Connect provider.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider
 */
data "aws_iam_openid_connect_provider" "this" {
  url = var.url
}

/**
`tls_certificate` data source gets information about the TLS certificates securing a host.
Use this data source to get information, such as SHA1 fingerprint or serial number, about the TLS certificates that protects a URL.
https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate
 */
data "tls_certificate" "this" {
  url = var.url
}

/**
Provides an IAM OpenID Connect provider.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
 */
resource "aws_iam_openid_connect_provider" "this" {
  # If the provider is existed, don't create a new one.
  count = (try(data.aws_iam_openid_connect_provider.this, null) == null || var.create_provider) ? 1 : 0

  url             = var.url
  client_id_list  = var.client_id_list
  thumbprint_list = distinct(concat(data.tls_certificate.this.certificates[0].sha1_fingerprint, var.additional_thumbprints))
}
