# Create the SES domain identity for the specified email domain
resource "aws_ses_domain_identity" "current" {
  domain = var.email_domain
}

# aws_ses_email_identity Provides an SES email identity resource


resource "aws_ses_email_identity" "emails" {
  count = length(var.emails)
  email = var.emails[count.index]
}

# Datasource to receive SES Full Access to the ses domain
data "aws_iam_policy_document" "this" {
  statement {
    effect    = "Allow"

    principals {
      type = "AWS"
      identifiers = var.principal_roles != null ? var.principal_roles : ["*"]
    }

    actions   = ["ses:*"]
    resources = [aws_ses_domain_identity.current.arn]
  }
}

resource "aws_iam_role_policy" "this" {
  count  = length(var.principal_roles)
  role   = var.principal_roles[count.index]
  policy = data.aws_iam_policy_document.this.json
}
