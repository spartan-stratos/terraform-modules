module "gcs_access_logs" {
  source = "./bucket-access-logs"

  log_sink_name      = var.bucket_name
  destination_bucket = var.destination_bucket
}
