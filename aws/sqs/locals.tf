locals {
  suffix         = var.fifo_enabled ? ".fifo" : ""
  dlq_queue_name = "${var.name}-dlq${local.suffix}"
  queue_name     = "${var.name}${local.suffix}"
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = data.aws_region.current.name
  queue_resources = concat([aws_sqs_queue.queue.arn], (var.enabled_dead_letter_queue == true ? [aws_sqs_queue.dlq[0].arn] : []))
}