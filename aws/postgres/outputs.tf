output "main_address" {
  description = "The address of the main database instance. This is used for direct connections to the primary database instance."
  value       = aws_db_instance.main.address
}

output "main_endpoint" {
  description = "The endpoint of primary database instance in address:port format.."
  value       = aws_db_instance.main.endpoint
}

output "replica_address" {
  description = "The endpoint of the first replica, fallback to the endpoint of the main instance if there is no replica."
  value       = try(aws_db_instance.replica[0].address, aws_db_instance.main.address)
}

output "main_db_name" {
  description = "The database name of the main database instance. This is used to identify the database when connecting to the instance."
  value       = aws_db_instance.main.db_name
}

output "jdbc_url" {
  description = "The JDBC format URL of primary RDS instance."
  value       = "jdbc:postgresql://${aws_db_instance.main.endpoint}/${aws_db_instance.main.db_name}"
}

output "db_identifier" {
  description = "The database identifier."
  value       = local.db_identifier
}

output "db_password" {
  description = "The password of database."
  value       = data.aws_secretsmanager_secret_version.postgresql_password.secret_string
  sensitive   = true
}
