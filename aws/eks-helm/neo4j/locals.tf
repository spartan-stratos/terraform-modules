locals {
  neo4j_password = var.neo4j_password != null ? var.neo4j_password : random_password.neo4j_password[0].result
  neo4j_fqdn     = var.neo4j_fqdn != "" ? var.neo4j_fqdn : local.neo4j_fqdn
}
