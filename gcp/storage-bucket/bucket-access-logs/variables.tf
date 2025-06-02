/**
Depend on root module input
 */
variable "destination_bucket" {
  description = "GCS bucket name where logs will be stored"
  type        = string
}

/**
Rigid
 */
variable "log_sink_name" {
  description = "Name of the log sink"
  type        = string
}
