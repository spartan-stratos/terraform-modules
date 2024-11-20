data "aws_iam_policy_document" "main_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ObjectOwnerOverrideToBucketOwner",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "readonly_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*"
    ]
  }
}

/*
aws_iam_policy main creates an IAM policy for write access to the specified S3 bucket.
The policy allows overriding object ownership to the bucket owner, uploading objects, and setting object ACLs.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
*/
resource "aws_iam_policy" "main" {
  name        = "S3PublicAssetsWrite-${var.bucket_name}"
  description = "Policy that allows writing to the s3 public assets bucket"

  policy = data.aws_iam_policy_document.main_policy.json
}

/*
aws_iam_policy readonly creates an IAM policy for read-only access to the specified S3 bucket.
The policy allows listing, getting objects, and viewing object ACLs within the bucket.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
*/
resource "aws_iam_policy" "readonly" {
  name        = "S3AssetsRead-${var.bucket_name}"
  description = "Policy that allows reading from the s3 assets bucket"

  policy = data.aws_iam_policy_document.readonly_policy.json
}
