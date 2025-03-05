/*
aws_cloudfront_origin_access_control configures access control settings for CloudFront to securely access the specified S3 bucket.
Enables signing behavior for security and ensures that the connection protocol is compatible with AWS SigV4 standards.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control
*/
resource "aws_cloudfront_origin_access_control" "this" {
  name                              = var.s3_bucket_id
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

/*
Defines a CloudFront Response Headers Policy to enforce security-related HTTP headers.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_response_headers_policy#content-type-options
 */
resource "aws_cloudfront_response_headers_policy" "this" {
  count = var.enabled_response_headers_policy ? 1 : 0
  name  = local.cloudfront_response_headers_policy_name

  security_headers_config {
    referrer_policy {
      override        = var.referrer_policy.override
      referrer_policy = var.referrer_policy.referrer_policy
    }

    content_security_policy {
      override                = var.content_security_policy.override
      content_security_policy = var.content_security_policy.content_security_policy
    }

    strict_transport_security {
      override                   = var.strict_transport_security.override
      access_control_max_age_sec = var.strict_transport_security.access_control_max_age_sec
      include_subdomains         = var.strict_transport_security.include_subdomains
      preload                    = var.strict_transport_security.preload
    }

    content_type_options {
      override = var.content_type_options.override
    }
  }
}

/*
aws_cloudfront_distribution defines a CloudFront distribution that serves content from an S3 bucket with custom caching and error responses.
This configuration includes SSL, origin access control, cache behavior, and custom error pages.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
*/
resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name              = data.aws_s3_bucket.this.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
    origin_id                = local.s3_origin_id
  }

  aliases = var.distribution_aliases != null ? var.distribution_aliases : [local.dns_name]

  enabled         = true
  is_ipv6_enabled = true

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behaviors
    content {
      path_pattern               = ordered_cache_behavior.value.path_pattern
      allowed_methods            = ordered_cache_behavior.value.allowed_methods
      cached_methods             = ordered_cache_behavior.value.cached_methods
      target_origin_id           = ordered_cache_behavior.value.target_origin_id
      response_headers_policy_id = var.enabled_response_headers_policy ? aws_cloudfront_response_headers_policy.this[0].id : null

      forwarded_values {
        query_string = ordered_cache_behavior.value.query_string

        cookies {
          forward = ordered_cache_behavior.value.cookies_forward
        }
      }

      viewer_protocol_policy = var.viewer_protocol_policy
      min_ttl                = ordered_cache_behavior.value.min_ttl
      default_ttl            = ordered_cache_behavior.value.default_ttl
      max_ttl                = ordered_cache_behavior.value.max_ttl
      compress               = ordered_cache_behavior.value.compress
    }
  }

  price_class = var.price_class

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.ssl_certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = var.minimum_protocol_version
  }

  retain_on_delete = true

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  web_acl_id = var.wafv2_arn
}

/*
aws_iam_policy_document generates an IAM policy document granting CloudFront access to S3 bucket objects.
This policy restricts access to the CloudFront service principal and only for the specific CloudFront distribution.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
*/
data "aws_iam_policy_document" "this" {
  statement {
    sid       = "AllowCloudFrontServicePrincipal"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.this.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.this.arn]
    }
  }
}

/*
aws_s3_bucket_policy attaches a policy to the S3 bucket, enabling CloudFront to access bucket objects.
This restricts access to requests that originate from the specified CloudFront distribution.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
*/
resource "aws_s3_bucket_policy" "react_app_bucket_policy" {
  bucket = data.aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}
