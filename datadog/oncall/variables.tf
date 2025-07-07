variable "team_id" {
  type = string
}

variable "urgency" {
  type    = string
  default = "high"
  validation {
    condition     = contains(["low", "dynamic", "high"], var.urgency)
    error_message = "Urgency must be one of 'low', 'dynamic', or 'high'."
  }
}
variable "schedule" {
  type = object({
    name      = string
    time_zone = string
    layer = object({
      name           = string
      effective_date = string
      rotation_start = string
      interval_days  = number
      users          = list(string)
    })
  })
}

variable "escalation_policy" {
  type = object({
    name                       = string
    resolve_page_on_policy_end = bool
    retries                    = number
  })
}