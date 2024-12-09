/*
`aws_ses_domain_identity` creates an SES domain identity for the specified email domain.
Used here to verify the ownership of the domain specified in `var.email_domain` for Amazon SES.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity
*/
resource "aws_ses_domain_identity" "this" {
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
`aws_route53_zone` data source retrieves information about a specific Route 53 hosted zone which can be useful for managing DNS records.
This data source is used here to get the hosted zone details of the domain specified in `var.email_domain`.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
*/
data "aws_route53_zone" "this" {
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
  zone_id = data.aws_route53_zone.this[0].zone_id
  ttl     = var.record_ttl
  records = [aws_ses_domain_identity.this.verification_token]
}

/*
`aws_ses_domain_identity_verification` performs verification of an SES domain identity.
Used here to verify the domain in Amazon SES, ensuring that the DNS verification record is successfully propagated.
The verification process depends on the Route 53 record created for domain verification.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification
*/
resource "aws_ses_domain_identity_verification" "this" {
  count  = var.use_route53 ? 1 : 0
  domain = aws_ses_domain_identity.this.domain

  depends_on = [aws_route53_record.verification]
}

/*
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
*/
data "aws_iam_policy_document" "identity_policy" {
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
    resources = [aws_ses_domain_identity.this.arn]
  }
}

/*
`aws_ses_identity_policy` attaches an IAM policy to an SES identity.
Used here to define and attach permissions to the domain identity specified in `aws_ses_domain_identity.current.arn`.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_identity_policy
*/
resource "aws_ses_identity_policy" "this" {
  identity = aws_ses_domain_identity.this.arn
  name     = "SES"
  policy   = data.aws_iam_policy_document.identity_policy.json
}

/*
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
 */
data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "ses:SendEmail",
      "ses:SendRawEmail"
    ]
    resources = [aws_ses_domain_identity.this.arn]
  }
}

/*
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
 */
resource "aws_iam_role_policy" "this" {
  count  = length(var.iam_role_ids)
  role   = var.iam_role_ids[count.index]
  policy = data.aws_iam_policy_document.this.json
}

