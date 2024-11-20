variable "cluster_name" {
  description = "The name of ECS cluster"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
