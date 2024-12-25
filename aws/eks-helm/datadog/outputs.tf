output "cluster_agent_auth_token" {
  value = random_password.cluster_agent_token.result
}
