output "cluster_id" {
  value       = qdrant-cloud_accounts_cluster.this.id
  description = "ID of the Qdrant cluster."
}

output "url" {
  value       = qdrant-cloud_accounts_cluster.this.url
  description = "URL to access the Qdrant cluster."
}

output "token" {
  value       = qdrant-cloud_accounts_auth_key.this.token
  description = "Token to authenticate with the Qdrant cluster."
}
