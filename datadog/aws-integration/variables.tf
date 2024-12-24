variable "datadog_aws_integration_iam_role" {
  description = "Name of the IAM role used for integrating Datadog with AWS."
  type        = string
  default     = "DatadogAWSIntegrationRole"
}

variable "datadog_permissions" {
  description = "List of AWS IAM permissions required for Datadog integration with AWS services."
  type        = list(string)
  default     = local.datadog_permissions
}

variable "aws_services_enabled" {
  description = "A map of AWS services with their enabled/disabled metric collection for specific AWS namespaces for this AWS account only."
  type        = map(bool)
  default     = local.aws_services_enabled
}
