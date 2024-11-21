/*
aws_s3_bucket main creates an S3 bucket with a specified name, adding environment tags for easier management.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
*/
resource "aws_s3_bucket" "with_prefix" {
  count         = var.bucket_name == null ? 1 : 0
  bucket_prefix = var.bucket_prefix
}

resource "aws_s3_bucket" "without_prefix" {
  count  = var.bucket_name != null ? 1 : 0
  bucket = var.bucket_name
}

locals {
  bucket = var.bucket_name != null ? aws_s3_bucket.without_prefix[0] : aws_s3_bucket.with_prefix[0]
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
