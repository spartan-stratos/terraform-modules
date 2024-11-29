# The address of the main instance
output "main_address" {
  value = module.main_db_instance.db_address
}

# The endpoint of the first replica, fallback to the endpoint of main instance if there is no replica
output "replica_address" {
  value = try(module.replica_db_instance[0].db_address, module.main_db_instance.db_address)
}

# The database name
output "db_name" {
  value = module.main_db_instance.db_name
}

output "db_username" {
  value = module.main_db_instance.db_username
}

output "db_password" {
  value = random_password.this.result
}