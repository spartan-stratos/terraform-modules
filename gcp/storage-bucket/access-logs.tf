module "gcs_access_logs" {
  source = "./bucket-access-logs"

  count = var.enable_access_logs ? 1 : 0

  log_sink_name      = var.bucket_name
  destination_bucket = var.destination_bucket
}
