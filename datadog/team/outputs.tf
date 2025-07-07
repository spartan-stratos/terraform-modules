output "team_id" {
  value = datadog_team.this.id
}

output "team_members_ids" {
  value = [for user in data.datadog_user.this : user.id]
}
