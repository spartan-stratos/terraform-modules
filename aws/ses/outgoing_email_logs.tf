module "outgoing_email_logs" {
  source = "./outgoing_email_logs"

  count = var.enabled_outgoing_email_logs == true ? 1 : 0

  environment      = var.environment
  name             = replace(var.email_domain, ".", "_")
  ses_identity_ids = concat([aws_ses_domain_identity.this.id], values(aws_ses_email_identity.emails))

  datadog_api_key                       = var.datadog_api_key
  datadog_site                          = var.datadog_site
  enabled_datadog_dashboard             = var.enabled_datadog_dashboard
  datadog_dashboard_environments        = var.datadog_dashboard_environments
  datadog_dashboard_default_environment = var.datadog_dashboard_default_environment

  enabled_outgoing_email_logs_cloudwatch = var.enabled_outgoing_email_logs_cloudwatch
}
