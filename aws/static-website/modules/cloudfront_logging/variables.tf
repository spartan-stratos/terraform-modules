variable "aws_cloudfront_distribution_arn" {
  description = "CloudFront distribution's arn as source to deliver logs."
  type        = string
}

variable "log_bucket_arn" {
  description = "Log bucket's arn that used to store CloudFront logs."
  type        = string
}

variable "log_bucket_prefix_path" {
  description = "Log bucket's prefix path."
  type        = string
}
