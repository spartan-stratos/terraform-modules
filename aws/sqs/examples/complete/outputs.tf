output "sqs_queue" {
  value = module.sqs.queue
}


output "sqs_queue_arn" {
  value = module.sqs.queue_arn
}

output "sqs_dlq" {
  value = module.sqs.dlq
}

output "sqs_dlq_arn" {
  value = module.sqs.dlq_arn
}

output "sqs_iam_policy_sqs_write_arn" {
  value = module.sqs.iam_policy_sqs_write_arn
}

output "sqs_iam_policy_sqs_read_arn" {
  value = module.sqs.iam_policy_sqs_read_arn
}
