module "github_actions_variables" {
  source = "../../modules/action-variables"

  repository = "service-platform"
  variables = {
    "VARIABLE" = "value"
  }
}
