module "gcs_access_logs" {
  source = "./bucket-access-logs"

  count = var.enable_access_logs ? 1 : 0

  bucket_name = google_storage_bucket.this.name
}
