/*
aws_s3_bucket main creates an S3 bucket with a specified name, adding environment tags for easier management.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
*/
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  tags = {
    environment = var.environment
  }
}

/*
aws_s3_bucket_ownership_controls main configures ownership settings for the S3 bucket, preferring ownership by the bucket owner.
This ensures that uploaded objects are owned by the bucket account for consistent permissions.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls
*/
resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

/*
aws_s3_bucket_cors_configuration main sets up CORS policies for the S3 bucket, allowing specified HTTP methods and origins.
Defines allowed headers and a maximum age for caching responses from S3.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration
*/
resource "aws_s3_bucket_cors_configuration" "main" {
  bucket = aws_s3_bucket.main.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST", "PUT", "GET"]
    allowed_origins = var.allowed_origins
    max_age_seconds = 3600
  }
}

/*
aws_s3_bucket_public_access_block block_public_access enforces public access restrictions on the S3 bucket.
It blocks public policies and restricts public bucket access while allowing public ACLs as configured.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
*/
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = false
  restrict_public_buckets = true
}
