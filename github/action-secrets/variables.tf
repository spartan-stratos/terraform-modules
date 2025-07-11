variable "repository" {
  description = "repository name"
  type        = string
}

variable "secrets" {
  description = "secrets to be set in the repository"
  sensitive   = true
  type        = map(string)
}
