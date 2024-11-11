output "queue" {
  description = "The SQS queue info"
  value       = aws_sqs_queue.queue
}

output "dlq" {
  description = "The SQS dead letter queue info"
  value       = aws_sqs_queue.dlq
}
