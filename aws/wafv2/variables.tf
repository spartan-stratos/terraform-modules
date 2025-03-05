variable "name" {
  type        = string
  description = "A friendly name of the WebACL."
}

variable "scope" {
  type        = string
  description = "The scope of this Web ACL. Valid options: CLOUDFRONT, REGIONAL."
}

variable "managed_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = string
    vendor_name     = string
    version         = optional(string)
    rule_action_override = list(object({
      name          = string
      action_to_use = string
    }))
  }))
  description = "List of Managed WAF rules."
  default     = []
}

variable "ip_sets_rule" {
  type = list(object({
    name          = string
    priority      = number
    ip_set_arn    = string
    action        = string
    response_code = optional(number, 403)
  }))
  description = "A rule to detect web requests coming from particular IP addresses or address ranges."
  default     = []
}

variable "ip_rate_based_rule" {
  type = object({
    name          = string
    priority      = number
    limit         = number
    action        = string
    response_code = optional(number, 403)
  })
  description = "A rate-based rule tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span"
  default     = null
}

variable "ip_rate_url_based_rules" {
  type = list(object({
    name                  = string
    priority              = number
    limit                 = number
    action                = string
    response_code         = optional(number, 403)
    search_string         = string
    positional_constraint = string
  }))
  description = "A rate and url based rules tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span"
  default     = []
}

variable "filtered_header_rule" {
  type = object({
    header_types  = list(string)
    priority      = number
    header_value  = string
    action        = string
    search_string = string
  })
  description = "HTTP header to filter . Currently supports a single header type and multiple header values."
  default     = null
}

variable "group_rules" {
  type = list(object({
    name            = string
    arn             = string
    priority        = number
    override_action = string
  }))
  description = "List of WAFv2 Rule Groups."
  default     = []
}

variable "default_action" {
  type        = string
  description = "The action to perform if none of the rules contained in the WebACL match."
  default     = "allow"
}

variable "cloudwatch_metrics_enabled" {
  type        = bool
  description = "Whether the associated resource sends metrics to CloudWatch."
  default     = false
}

variable "sampled_requests_enabled" {
  type        = bool
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules."
  default     = false
}

variable "web_acl_associations_arn" {
  type        = string
  default     = null
  description = "A resource ARN to associate with the Web ACL"
}

variable "enabled_wafv2_web_acl_association" {
  type    = bool
  default = false
}
