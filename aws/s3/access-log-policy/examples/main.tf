module "access_logs" {
  source                 = "../"
  source_bucket_arns     = ["arn:aws:s3:::my-source-bucket"]
  access_logs_bucket_id  = "my-access-logs-bucket"
  access_logs_bucket_arn = "arn:aws:s3:::my-access-logs-bucket"
}
