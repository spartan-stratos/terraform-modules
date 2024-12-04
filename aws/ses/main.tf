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
  count = length(var.emails)
  email = var.emails[count.index]
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

    actions   = ["ses:*"]
    resources = [aws_ses_domain_identity.current.arn]
  }
}

/*
`aws_iam_role_policy` attaches an IAM policy to the specified roles in `var.principal_roles`.
Used here to grant the roles the permissions defined in the generated IAM policy document.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
*/
resource "aws_iam_role_policy" "this" {
  count  = length(var.principal_roles)
  role   = var.principal_roles[count.index]
  policy = data.aws_iam_policy_document.this.json
}