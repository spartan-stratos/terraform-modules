variable "dns_name" {
  description = "The DNS name for the static website"
  type        = string
}

variable "enabled_create_s3" {
  description = "The bool value determining whether to create a new S3 bucket"
  type        = bool
}

variable "global_tls_certificate_arn" {
  description = "The TLS certificate arn for the root domain name"
  type        = string
}

variable "name" {
  description = "For creating or retrieving the bucket and cloudfront name"
  type        = string
}

variable "route53_zone_id" {
  description = "R53 zone ID"
  type        = string
}

variable "route53_zone_name" {
  description = "R53 zone name"
  type        = string
}
