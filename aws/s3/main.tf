locals {
  bucket = var.bucket_name != null ? aws_s3_bucket.without_prefix[0] : aws_s3_bucket.with_prefix[0]
}

/*
aws_s3_bucket main creates an S3 bucket with a specified name, adding environment tags for easier management.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
*/
resource "aws_s3_bucket" "with_prefix" {
  count         = var.bucket_name == null ? 1 : 0
  bucket_prefix = var.bucket_prefix
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket" "without_prefix" {
  count         = var.bucket_name != null ? 1 : 0
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
}

/*
aws_s3_bucket_ownership_controls main configures ownership settings for the S3 bucket, preferring ownership by the bucket owner.
This ensures that uploaded objects are owned by the bucket account for consistent permissions.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls
*/
resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.object_ownership != null ? 1 : 0
  bucket = local.bucket.id

  rule {
    object_ownership = var.object_ownership
  }
}

/*
aws_s3_bucket_cors_configuration main sets up CORS policies for the S3 bucket, allowing specified HTTP methods and origins.
Defines allowed headers and a maximum age for caching responses from S3.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration
*/
resource "aws_s3_bucket_cors_configuration" "this" {
  count  = var.enabled_cors ? 1 : 0
  bucket = local.bucket.id

  dynamic "cors_rule" {
    for_each = [var.cors_configuration]
    content {
      allowed_headers = try(cors_rule.value.allowed_headers, [])
      expose_headers  = try(cors_rule.value.expose_headers, [])
      allowed_methods = try(cors_rule.value.allowed_methods, [])
      allowed_origins = try(cors_rule.value.allowed_origins, [])
      max_age_seconds = try(cors_rule.value.max_age_seconds, 3600)
    }
  }
}

/*
aws_s3_bucket_public_access_block block_public_access enforces public access restrictions on the S3 bucket.
It blocks public policies and restricts public bucket access while allowing public ACLs as configured.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
*/
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = local.bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

/*
aws_iam_policy_document generates an IAM policy document granting public access to S3 bucket objects.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
*/
data "aws_iam_policy_document" "this" {
  count = var.enabled_public_policy ? 1 : 0

  statement {
    sid       = "PublicReadGetObject"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${local.bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.disabled_s3_http_access ? [1] : []
    content {
      actions = [
        "s3:*",
      ]

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["false"]
      }

      effect = "Deny"

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      resources = [
        local.bucket.arn,
        "${local.bucket.arn}/*",
      ]
    }
  }
}

/*
aws_s3_bucket_policy attaches a policy to the S3 bucket, enabling the public access to bucket objects.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
*/
resource "aws_s3_bucket_policy" "this" {
  count  = var.enabled_public_policy ? 1 : 0
  bucket = local.bucket.id
  policy = data.aws_iam_policy_document.this.0.json
}

/*
aws_s3_bucket_versioning sets versioning status on the S3 bucket.
Versioning is disabled by default, meaning previous versions of files won't be retained.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
*/
resource "aws_s3_bucket_versioning" "this" {
  bucket = local.bucket.id
  versioning_configuration {
    status = var.versioning_status
  }
}

/**
aws_s3_bucket_acl provides an S3 bucket ACL resource.
NOTE:
- terraform destroy does not delete the S3 Bucket ACL but does remove the resource from Terraform state.
- This resource cannot be used with S3 directory buckets.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
 */
resource "aws_s3_bucket_acl" "this" {
  count = var.acl == "public-read" ? 1 : 0
  depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_public_access_block.this,
  ]

  bucket = local.bucket.id
  acl    = var.acl
}

resource "aws_s3_bucket_logging" "this" {
  count = var.enabled_access_logging ? 1 : 0

  bucket = local.bucket.id

  target_bucket = var.access_log_target_bucket_id
  target_prefix = var.access_log_target_prefix
}

module "access_log_policy" {
  count = length(var.write_access_logs_source_bucket_arns) > 0 ? 1 : 0

  source = "./access-log-policy"

  access_logs_bucket_id  = local.bucket.id
  access_logs_bucket_arn = local.bucket.arn
  source_bucket_arns     = var.write_access_logs_source_bucket_arns
}
