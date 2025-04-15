resource "aws_s3_bucket_logging" "this" {
  count = var.enabled_access_logging ? 1 : 0

  bucket = local.bucket.id

  target_bucket = var.access_log_target_bucket_id
  target_prefix = var.access_log_target_prefix
}

module "access_log_policy" {
  count = length(var.write_access_logs_source_bucket_arns) > 0 ? 1 : 0

  source = "./access-log-policy"

  access_logs_bucket_id  = local.bucket.id
  access_logs_bucket_arn = local.bucket.arn
  source_bucket_arns     = var.write_access_logs_source_bucket_arns
}
