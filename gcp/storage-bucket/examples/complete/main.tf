module "storage_bucket" {
  source = "../../"

  bucket_name = "example-bucket"
  environment = "example-environment"
}
