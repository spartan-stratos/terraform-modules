variable "source_bucket_arns" {
  description = "The source buckets that can write to the access logs bucket"
  type        = list(string)
  default     = []
}

variable "access_logs_bucket_id" {
  description = "The access logs bucket"
  type        = string
}
