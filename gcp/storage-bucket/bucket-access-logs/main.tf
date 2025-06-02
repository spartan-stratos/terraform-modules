data "google_project" "this" {}

resource "google_logging_project_sink" "this" {
  name        = var.log_sink_name
  project     = data.google_project.this.project_id
  destination = "storage.googleapis.com/${var.destination_bucket}"

  filter                 = "resource.type=\"gcs_bucket\" AND protoPayload.methodName:(\"storage.objects.get\" OR \"storage.objects.list\")"
  unique_writer_identity = true
}

resource "google_storage_bucket_iam_member" "this" {
  bucket = var.destination_bucket
  role   = "roles/storage.objectCreator"
  member = google_logging_project_sink.this.writer_identity
}
