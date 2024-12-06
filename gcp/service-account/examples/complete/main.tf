module "service_account" {
  source = "../../"

  project_id                 = "example-project"
  service_account_id         = "example"
  enabled_service_account    = true
  enabled_create_custom_role = true
  permissions = [
    "storage.buckets.get",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
  ]
}