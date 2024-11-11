module "website" {
  source = "../../"

  dns_zone         = "example.com"
  environment      = "dev"
  repository       = "https://github.com/example-org/example-repo"
  application_root = "./"
  build_variables = {
    NEXT_PUBLIC_DOMAIN = "https://test.example.com"
    NEXT_PUBLIC_ENV    = "dev"
  }
  github_token             = "example"
  deploy_branch_name       = "master"
  sub_domain               = "test"
  name                     = "example"
  install_command          = "yarn install"
  build_command            = "yarn build"
  base_artifacts_directory = ".next"
}
