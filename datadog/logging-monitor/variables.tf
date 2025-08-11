variable "high_number_of_errors" {
  type = object({
    name                    = string
    priority                = optional(number, 5)
    message                 = optional(string, null)
    service_regex           = optional(string, "*")
    source                  = optional(string, "all")
    critical                = optional(number, 1)
    critical_recovery       = optional(number, 0)
    additional_filter_regex = optional(string, "")
    time_window             = optional(string, "1d")
  })
  default = null
}

variable "new_issue" {
  type = object({
    name                    = string
    priority                = optional(number, 5)
    message                 = optional(string, null)
    service_regex           = optional(string, "*")
    source                  = optional(string, "all")
    critical                = optional(number, 1)
    critical_recovery       = optional(number, 0)
    additional_filter_regex = optional(string, "")
  })
  default = null
}

variable "require_full_window" {
  default = false
}

variable "environment" {
  type = string
}
