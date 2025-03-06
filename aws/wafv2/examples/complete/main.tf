module "geo_rules" {
  source = "../geo-rules"
  environment = "dev" # local.environment
}

module "wafv2_cloudfront" {
  providers = {
    aws = aws.global
  }

  source = "../.."

  name  = "cloudfront-name"
  scope = "CLOUDFRONT"
  managed_rules = [
    {
      name                 = "AWSManagedRulesCommonRuleSet",
      override_action      = "none",
      priority             = 1,
      vendor_name          = "AWS"
      rule_action_override = []
    }
  ]

  geo_rules = module.geo_rules.geo_rules
}

module "wafv2_alb" {
  source = "../.."

  name  = "alb-name"
  scope = "REGIONAL"
  managed_rules = [
    {
      name            = "AWSManagedRulesCommonRuleSet",
      override_action = "none",
      priority        = 1,
      vendor_name     = "AWS"
      rule_action_override = [
        {
          name          = "SizeRestrictions_BODY"
          action_to_use = "allow"
        }
      ]
    }
  ]

  geo_rules = module.geo_rules.geo_rules
}
