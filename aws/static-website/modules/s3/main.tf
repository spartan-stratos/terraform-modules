/*
aws_s3_bucket creates an S3 bucket with a unique prefix derived from stack name, bucket name, and environment.
The force_destroy option allows bucket deletion even if it contains objects.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
*/
resource "aws_s3_bucket" "this" {
  bucket_prefix = "${var.stack_name}-${var.name}-${var.environment}-"
  force_destroy = true
}

/*
aws_s3_bucket_public_access_block restricts public access to the S3 bucket by blocking all public policies and ACLs.
This is crucial for securing the bucket and avoiding accidental exposure of sensitive data.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
*/
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/*
aws_s3_bucket_versioning sets versioning status on the S3 bucket.
Versioning is disabled by default, meaning previous versions of files won't be retained.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
*/
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Disabled"
  }
}
