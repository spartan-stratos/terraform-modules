module "github_oidc" {
  source          = "../../"
  role_name       = "service-atlas"
  repository_path = "spartan/example"

  role_policy_arns = []
  aws_account_id   = "example-id"
}
