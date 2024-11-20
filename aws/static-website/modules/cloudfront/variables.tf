variable "dns_name" {
  description = "The DNS name for the static website"
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 zone id"
  type        = string
}

variable "route53_zone_name" {
  description = "Route53 zone name"
  type        = string
}

variable "s3_bucket_id" {
  description = "The origin S3 bucket id"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "SSL certificate arn for attaching to the Cloudfront distribution"
  type        = string
}
