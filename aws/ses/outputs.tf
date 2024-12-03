output "domain_identity_arn" {
  value       = aws_ses_domain_identity.current.arn
  description = "The ARN of the SES domain identity for the email domain."
}