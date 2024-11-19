variable "environment" {
  description = "The environment name"
  type        = string
}

variable "bucket_name" {
  description = "The bucket name to be created"
  type        = string
}

variable "allowed_origins" {
  description = "Custom allowed origins for the bucket configuration"
  type        = list(string)
}
