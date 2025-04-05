data "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_id
}

resource "aws_s3_bucket_website_configuration" "main" {
  count = var.s3_redirect_domain != null ? 1 : 0

  bucket = data.aws_s3_bucket.this.id

  redirect_all_requests_to {
    host_name = var.s3_redirect_domain
  }
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