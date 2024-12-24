variable "datadog_account_id" {
  description = "The datadog account name to create."
  type        = string
}

variable "host_filters" {
  description = "A string used to filter the hosts sent from GCP to Datadog. Only hosts matching the specified tags will be included. Tags should be in the format 'key:value' and multiple tags can be separated by commas (e.g., 'environment:production,datadog:true')."
  type        = string
  default     = "datadog:true"
}

variable "datadog_roles" {
  description = "Datadog service account should have compute.viewer, monitoring.viewer, cloudasset.viewer, and browser roles (the browser role is only required in the default project of the service account)."
  type        = list(string)
  default = [
    "roles/compute.viewer",
    "roles/container.viewer",
    "roles/monitoring.viewer",
    "roles/cloudasset.viewer",
    "roles/browser"
  ]
}
