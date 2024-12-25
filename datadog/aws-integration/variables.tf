variable "datadog_aws_integration_iam_role" {
  description = "Name of the IAM role used for integrating Datadog with AWS."
  type        = string
  default     = "DatadogAWSIntegrationRole"
}

variable "datadog_permissions" {
  description = "List of AWS IAM permissions required for Datadog integration with AWS services. Reference: https://docs.datadoghq.com/integrations/amazon_web_services/#aws-integration-iam-policy."
  type        = list(string)
  default     = null
}

variable "aws_services_enabled" {
  description = "A map of AWS services with their enabled/disabled metric collection for specific AWS namespaces for this AWS account only. Reference: https://docs.datadoghq.com/integrations/#cat-aws."
  type        = map(bool)
  default     = null
}
