locals {
  aws_services_enabled = {
    "elasticache" = true
    "rds"         = true
  }
}

module "datadog_aws_integration" {
  source = "../../"

  aws_services_enabled = local.aws_services_enabled
}
