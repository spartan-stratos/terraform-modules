data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "S3ServerAccessLogsPolicy"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = toset(["${var.access_logs_bucket_id}/s3-access-logs/*"])
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = var.source_bucket_arns
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_server_write_access_log" {
  policy = data.aws_iam_policy_document.this.json
  bucket = var.access_logs_bucket_id
}
