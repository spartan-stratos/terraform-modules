data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "datadog_aws_integration_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.datadog_aws_account_id}:root"]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        "${datadog_integration_aws.sandbox.external_id}"
      ]
    }
  }
}

data "aws_iam_policy_document" "datadog_aws_integration" {
  statement {
    actions   = var.datadog_permissions == null ? local.datadog_permissions : var.datadog_permissions
    resources = ["*"]
  }
}

resource "aws_iam_policy" "datadog_aws_integration" {
  name   = "DatadogAWSIntegrationPolicy"
  policy = data.aws_iam_policy_document.datadog_aws_integration.json
}

resource "aws_iam_role" "datadog_aws_integration" {
  name               = var.datadog_aws_integration_iam_role
  description        = "Role for Datadog AWS Integration"
  assume_role_policy = data.aws_iam_policy_document.datadog_aws_integration_assume_role.json
}

resource "aws_iam_role_policy_attachment" "datadog_aws_integration" {
  role       = aws_iam_role.datadog_aws_integration.name
  policy_arn = aws_iam_policy.datadog_aws_integration.arn
}

/**
Create and manage Datadog - Amazon Web Services integration.
https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/integration_aws
 */
resource "datadog_integration_aws" "sandbox" {
  account_id                           = data.aws_caller_identity.this.account_id
  role_name                            = var.datadog_aws_integration_iam_role
  extended_resource_collection_enabled = false
  metrics_collection_enabled           = true
  account_specific_namespace_rules     = var.aws_services_enabled == null ? local.aws_services_enabled : var.aws_services_enabled
}
