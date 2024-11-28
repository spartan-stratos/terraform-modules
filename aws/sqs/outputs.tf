output "queue" {
  description = "The SQS queue info"
  value       = aws_sqs_queue.queue
}

output "dlq" {
  description = "The SQS dead letter queue info"
  value       = aws_sqs_queue.dlq
}

output "iam_policy_sqs_write_arn" {
  value = aws_iam_policy.write.arn
}

output "iam_policy_sqs_read_arn" {
  value = aws_iam_policy.read.arn
}
