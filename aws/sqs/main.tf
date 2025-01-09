/*
aws_sqs_queue dlq creates a dead-letter queue (DLQ) for handling messages that can't be processed successfully.
Configured with default SQS settings and optional FIFO settings based on input variables.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue
*/
resource "aws_sqs_queue" "dlq" {
  count                     = var.enabled_dead_letter_queue ? 1 : 0
  name                      = local.dlq_queue_name
  delay_seconds             = "0"
  max_message_size          = var.max_size
  message_retention_seconds = var.dlq_retention_seconds
  receive_wait_time_seconds = "0"

  fifo_queue = var.fifo_enabled
}

/*
aws_sqs_queue queue creates the main SQS queue with configuration for visibility, delay, retention, and optional FIFO.
Supports dead-letter queue policies and FIFO settings.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue
*/
resource "aws_sqs_queue" "queue" {
  name                       = local.queue_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_size
  message_retention_seconds  = var.retention_seconds
  receive_wait_time_seconds  = var.wait_seconds

  fifo_queue            = var.fifo_enabled
  deduplication_scope   = var.fifo_deduplication_scope
  fifo_throughput_limit = var.fifo_throughput_limit

  redrive_policy = var.enabled_dead_letter_queue ? local.redrive_policy : null
}

locals {
  redrive_policy = <<POLICY
{
  "deadLetterTargetArn":"${try(aws_sqs_queue.dlq[0].arn, "")}",
  "maxReceiveCount": ${var.max_receive_count}
}
POLICY
}

/*
aws_iam_policy_document creates an IAM policy document allowing specified roles (or any if unspecified)
to access the main SQS queue. This can restrict access to specific AWS principals.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
*/
data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principal_roles != null ? var.principal_roles : ["*"]
    }

    actions   = ["sqs:*"]
    resources = [aws_sqs_queue.queue.arn]
  }
}

/*
aws_sqs_queue_policy attaches the IAM policy document to the main SQS queue.
This policy controls access to the queue based on the specified IAM roles or all users.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy
*/
resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.queue.id
  policy    = data.aws_iam_policy_document.this.json
}
