output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = try(aws_acm_certificate_validation.this[0].certificate_arn, aws_acm_certificate.this[0].arn, "")
}

output "acm_certificate_domain_validation_options" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = flatten(aws_acm_certificate.this[*].domain_validation_options)
}

output "acm_certificate_status" {
  description = "Status of the certificate."
  value       = try(aws_acm_certificate.this[0].status, "")
}

output "validation_route53_record_fqdns" {
  description = "List of FQDNs built using the zone domain and name."
  value       = aws_route53_record.validation[*].fqdn
}
