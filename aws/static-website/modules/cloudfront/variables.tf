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

variable "distribution_aliases" {
  description = "List of domain names that associate with the CloudFront distribution."
  type        = list(string)
  default     = null
}

variable "ordered_cache_behaviors" {
  description = "List of ordered cache behaviors with path patterns and settings."
  type = list(object({
    path_pattern     = string
    allowed_methods  = list(string)
    cached_methods   = list(string)
    target_origin_id = string
    query_string     = bool
    cookies_forward  = string
    min_ttl          = number
    default_ttl      = number
    max_ttl          = number
    compress         = bool
  }))
  default = []
}
