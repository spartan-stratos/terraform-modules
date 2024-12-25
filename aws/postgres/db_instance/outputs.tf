output "db_identifier" {
  description = "The instance identifier name."
  value       = aws_db_instance.this.identifier
}

output "db_address" {
  description = "The hostname of the instance."
  value       = aws_db_instance.this.address
}

output "db_name" {
  description = "The database name."
  value       = aws_db_instance.this.db_name
}

output "db_username" {
  description = "The database username."
  value       = aws_db_instance.this.username
}

output "db_port" {
  description = "The database port."
  value       = aws_db_instance.this.port
}
