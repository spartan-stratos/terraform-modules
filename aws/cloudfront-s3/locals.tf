locals {
  cloudfront_response_headers_policy_name = "cloudfront-headers-policy"
  s3_origin_id                            = "s3-origin-${var.s3_bucket_id}"
}
