variable "dns_name" {
  description = "The DNS name for the static website"
  type        = string
  default     = null
}

variable "domain_name" {
  description = "The domain name for the static website."
  type        = string
}

variable "enabled_create_s3" {
  description = "The bool value determining whether to create a new S3 bucket"
  type        = bool
}

variable "existing_s3_bucket_name" {
  description = "The name of the existing S3 bucket to use"
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

variable "use_www_domain" {
  description = "Use www domain"
  type        = bool
  default     = false
}

variable "cloudfront_distribution_aliases" {
  description = "List of domain names that is associated with the CloudFront distribution."
  type        = list(string)
  default     = null
}

# avoid recreating policies and their dependent resources during migration
variable "s3_read_write_policy_description" {
  description = "Description for read write policy"
  type        = string
  default     = "Policy that allows writing to the S3 bucket"
}

variable "s3_readonly_policy_description" {
  description = "Description for readonly policy"
  type        = string
  default     = "Policy that allows reading from the s3 assets bucket"
}

# Custom name
variable "bucket_prefix" {
  description = "Overwrite bucket prefix name."
  type        = string
  default     = null
}

variable "s3_custom_readonly_policy_name" {
  description = "The custom read only policy name to overwrite default one"
  type        = string
  default     = null
}

variable "s3_custom_read_write_policy_name" {
  description = "The custom read write policy name to overwrite default one"
  type        = string
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
