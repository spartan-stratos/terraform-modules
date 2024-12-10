data "aws_iam_policy_document" "this_policy" {
  count = var.enabled_iam_policy ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "s3:ObjectOwnerOverrideToBucketOwner",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
    resources = [
      local.bucket.arn,
      "${local.bucket.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "readonly_policy" {
  count = var.enabled_iam_policy ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListBucket",
    ]
    resources = [
      local.bucket.arn,
      "${local.bucket.arn}/*"
    ]
  }
}

/*
aws_iam_policy main creates an IAM policy for write access to the specified S3 bucket.
The policy allows overriding object ownership to the bucket owner, uploading objects, and setting object ACLs.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
*/
resource "aws_iam_policy" "this" {
  count       = var.enabled_iam_policy ? 1 : 0
  name        = "S3PublicAssetsWrite-${local.bucket.bucket}"
  description = "Policy that allows writing to the s3 public assets bucket"

  policy = data.aws_iam_policy_document.this_policy.0.json
}

/*
aws_iam_policy readonly creates an IAM policy for read-only access to the specified S3 bucket.
The policy allows listing, getting objects, and viewing object ACLs within the bucket.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
*/
resource "aws_iam_policy" "readonly" {
  count       = var.enabled_iam_policy ? 1 : 0
  name        = "S3AssetsRead-${local.bucket.bucket}"
  description = "Policy that allows reading from the s3 assets bucket"

  policy = data.aws_iam_policy_document.readonly_policy.0.json
}


/*
aws_iam_policy read_write_policy creates an IAM policy for read_write_policy access to the specified S3 bucket.
The policy allows listing, getting objects, and viewing object ACLs within the bucket.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
*/
data "aws_iam_policy_document" "read_write_policy" {
  count = var.enabled_iam_policy ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListBucket",
      "s3:ObjectOwnerOverrideToBucketOwner",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
}

# Create the read-write IAM policy
resource "aws_iam_policy" "read_write" {
  count       = var.enabled_iam_policy ? 1 : 0
  name        = "S3ReadWrite-${aws_s3_bucket.bucket.bucket}"
  description = "Policy that allows writing to the S3 bucket"
  policy      = data.aws_iam_policy_document.read_write_policy.json
}
