module "gcs_access_logs" {
  source = "../../bucket-access-logs"

  log_sink_name      = "gcs-access-logs"
  destination_bucket = "my-gcs-log-bucket"
  log_prefix         = "logs/"
}
