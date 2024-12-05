/*
`aws_ses_domain_identity` creates an SES domain identity for the specified email domain.
Used here to verify the ownership of the domain specified in `var.email_domain` for Amazon SES.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity
*/
resource "aws_ses_domain_identity" "current" {
  domain = var.email_domain
}

/*
`aws_ses_email_identity` `emails` provides an SES email identity resource for verifying email addresses in Amazon SES.
Used here to create email identities for all emails listed in the `var.emails` variable.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_email_identity
*/
resource "aws_ses_email_identity" "emails" {
  for_each = toset(var.emails)
  email    = each.value
}

/*
`aws_route53_zone` creates a Route 53 hosted zone for managing DNS records for a specific domain.
Used here to provision a hosted zone for the domain specified in `var.email_domain` if `var.use_route53` is set to `true`.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
*/
resource "aws_route53_zone" "this" {
  count = var.use_route53 ? 1 : 0
  name  = var.email_domain
}

/*
`aws_route53_record` creates a DNS TXT record for domain verification in Amazon SES.
Used here to add a verification record for the domain specified in `var.email_domain` to confirm domain ownership in SES.
The record is only created if `var.use_record` is `true`.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
*/
resource "aws_route53_record" "verification" {
  count   = var.use_route53 ? 1 : 0
  name    = var.email_domain
  type    = var.record_type
  zone_id = aws_route53_zone.this[0].zone_id
  ttl     = var.record_ttl
  records = [aws_ses_domain_identity.current.verification_token]
}

/*
`aws_ses_domain_identity_verification` performs verification of an SES domain identity.
Used here to verify the domain in Amazon SES, ensuring that the DNS verification record is successfully propagated.
The verification process depends on the Route 53 record created for domain verification.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification
*/
resource "aws_ses_domain_identity_verification" "this" {
  count  = var.use_route53 ? 1 : 0
  domain = aws_ses_domain_identity.current.domain

  depends_on = [aws_route53_record.verification]
}

/*
`aws_iam_policy_document` generates an IAM policy document to allow SES full access for the specified principals.
Used here to define permissions for roles or entities in `var.principal_roles` to access the SES domain.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
*/
data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principal_roles != null ? var.principal_roles : ["*"]
    }

    actions = [
      "ses:SendEmail",
      "ses:SendRawEmail"
    ]
    resources = [aws_ses_domain_identity.current.arn]
  }
}

/*
`aws_iam_role_policy` attaches an IAM policy to the specified roles in `var.principal_roles`.
Used here to grant the roles the permissions defined in the generated IAM policy document.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
*/
resource "aws_iam_role_policy" "this" {
  role   = aws_ses_domain_identity.current.id
  policy = data.aws_iam_policy_document.this.json
}

/*
`aws_ses_identity_policy` attaches an IAM policy to an SES identity.
Used here to define and attach permissions to the domain identity specified in `aws_ses_domain_identity.current.arn`.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_identity_policy
*/
resource "aws_ses_identity_policy" "this" {
  identity = aws_ses_domain_identity.current.arn
  name     = "SES"
  policy   = data.aws_iam_policy_document.this.json
}
