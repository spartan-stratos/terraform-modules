output "arn" {
  description = "Amazon Resource Name (ARN) of the GuardDuty detector"
  value       = aws_guardduty_detector.this.arn
}

output "account_id" {
  description = "The AWS account ID of the GuardDuty detector"
  value       = aws_guardduty_detector.this.account_id
}
