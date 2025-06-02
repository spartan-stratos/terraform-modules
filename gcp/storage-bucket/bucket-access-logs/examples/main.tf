module "gcs_access_logs" {
  source = "../../bucket-access-logs"

  bucket_name = "log-bucket"
}
