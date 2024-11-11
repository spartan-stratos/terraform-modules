variable "environment" {
  description = "The environment name"
  type        = string
}

variable "dns_name" {
  description = "The DNS name for the static website"
  type        = string
}

variable "global_tls_certificate_arn" {
  description = "The TLS certificate arn for the root domain name"
  type        = string
}

variable "name" {
  description = "For creating the bucket and cloudfront name"
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

variable "stack_name" {
  description = "The stack name"
  type        = string
}
