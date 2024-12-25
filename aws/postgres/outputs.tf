output "main_address" {
  description = "The primary instance hostname."
  value       = module.main_db_instance.db_address
}

output "replica_address" {
  description = "The replica hostname, fallback to the hostname of main instance if there is no replica."
  value       = try(module.replica_db_instance[0].db_address, module.main_db_instance.db_address)
}

output "db_name" {
  description = "The database name."
  value       = module.main_db_instance.db_name
}

output "db_username" {
  description = "The database username."
  value       = module.main_db_instance.db_username
}

output "db_port" {
  description = "The database port."
  value       = module.main_db_instance.db_port
}

output "db_password" {
  description = "The database password."
  value       = random_password.this.result
}
