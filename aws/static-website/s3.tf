module "s3" {
  source = "../s3"

  bucket_prefix = var.name

  force_destroy = true
}
