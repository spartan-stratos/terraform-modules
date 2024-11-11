output "sqs_queue" {
  value = module.sqs.queue
}

output "sqs_dlq" {
  value = module.sqs.dlq
}
