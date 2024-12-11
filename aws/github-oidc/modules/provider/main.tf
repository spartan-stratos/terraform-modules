data "aws_iam_openid_connect_provider" "github_oidc" {
  url = var.url
}

data "tls_certificate" "this" {
  url = var.url
}

resource "aws_iam_openid_connect_provider" "github_oidc" {
  # If the provider is already there, don't create a new one.
  count           = data.aws_iam_openid_connect_provider.github_oidc == null ? 1 : 0
  url             = var.url
  client_id_list  = var.client_id_list
  thumbprint_list = distinct(concat(data.tls_certificate.this.certificates[0].sha1_fingerprint, var.additional_thumbprints))
}
