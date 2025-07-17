module "recaptcha" {
  source = "../.."

  environment = "dev"

  # Android settings
  allow_all_package_names = false
  allowed_package_names   = ["com.example.app.dev"]

  #iOS settings
  allow_all_bundle_ids = false
  allowed_bundle_ids   = ["dev.example.app"]
}