module "provider" {
  source = "./modules/provider"
}

locals {
  github_oidc_provider_arn = module.provider.arn
  github_oidc_provider_url = module.provider.url
}
