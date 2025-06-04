data "aws_s3_bucket" "this" {
  count = var.enabled_create_s3 ? 0 : 1

  bucket = var.existing_s3_bucket_name != null ? var.existing_s3_bucket_name : var.name
}

module "s3" {
  source = "../s3"

  count = var.enabled_create_s3 ? 1 : 0

  bucket_prefix = var.bucket_prefix != null ? var.bucket_prefix : var.name
  force_destroy = true

  create_bucket_policy      = false
  enabled_read_only_policy  = var.enabled_read_only_policy
  enabled_read_write_policy = var.enabled_read_write_policy

  custom_readonly_policy_name = var.s3_custom_readonly_policy_name
  readonly_policy_description = var.s3_readonly_policy_description

  custom_read_write_policy_name = var.s3_custom_read_write_policy_name
  read_write_policy_description = var.s3_read_write_policy_description

  versioning_status = var.versioning_status
}
