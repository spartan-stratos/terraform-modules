module "github_actions_secrets" {
  source = "../../modules/action-secrets"

  repository = "service-platform"
  secrets = {
    "SECRET" = "value"
  }
}
