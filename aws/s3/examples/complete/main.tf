module "s3_bucket" {
  source          = "../../"

  environment     = "dev"
  bucket_name     = "example-bucket"
  allowed_origins = ["example.com"]
}
