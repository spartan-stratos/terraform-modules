module "aws_scheduler" {
  source = "../../"

  name    = "example-scheduler"
  sqs_arn = "arn:aws:sqs:<region>:<account_id>:<queue_name>"
  message_body = jsonencode({
    type = "cronjob"
    kind = "example-payload"
  })
  queue_url = "https://sqs.<region>.amazonaws.com/<account_id>:<queue_name>"
}