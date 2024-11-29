output "db_identifier" {
  value = aws_db_instance.this.identifier
}


output "db_address" {
  value = aws_db_instance.this.address
}

output "db_name" {
  value = aws_db_instance.this.db_name
}

output "db_username" {
  value = aws_db_instance.this.username
}
