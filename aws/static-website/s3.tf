data "aws_s3_bucket" "this" {
  count = var.enabled_create_s3 ? 0 : 1

  bucket = var.existing_s3_bucket_name != null ? var.existing_s3_bucket_name : var.name
}

module "s3" {
  source = "../s3"

  count = var.enabled_create_s3 ? 1 : 0

  bucket_prefix             = var.name
  force_destroy             = true
  enabled_read_only_policy  = var.enabled_read_only_policy
  enabled_read_write_policy = var.enabled_read_write_policy
}
