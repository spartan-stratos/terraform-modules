variable "dns_name" {
  description = "The DNS name for the static website"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the static website."
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 zone id"
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

variable "use_www_domain" {
  description = "Use www domain"
  type        = bool
  default     = false
}
