variable "dns_name" {
  description = "The DNS name for the static website"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the static website."
  type        = string
}

variable "enabled_create_s3" {
  description = "The bool value determining whether to create a new S3 bucket"
  type        = bool
}

variable "create_s3_bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
  default     = null
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

variable "viewer_protocol_policy" {
  description = "Determines the protocols that viewers can use to access your CloudFront distribution."
  type        = string
  default     = "redirect-to-https"
}

variable "minimum_protocol_version" {
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  type        = string
  default     = "TLSv1.2_2021"
}

variable "price_class" {
  description = "The price class for this distribution."
  type        = string
  default     = "PriceClass_100"
}

variable "enabled_public_policy" {
  description = "Enabled create the Public Policy to allow public access to bucket objects."
  type        = bool
  default     = false
}

variable "enabled_read_write_policy" {
  description = "Enabled create the Read Write Policy to allow access to bucket objects."
  type        = bool
  default     = false
}

variable "enabled_read_only_policy" {
  description = "Enabled create the Read Only Policy to allow access to bucket objects."
  type        = bool
  default     = false
}
