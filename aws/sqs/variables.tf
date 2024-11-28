variable "name" {
  description = "The name for creating queue names"
  type        = string
}

variable "fifo_enabled" {
  description = "Specify whether enable FIFO or not for the SQS queue"
  type        = bool
  default     = false
}

variable "fifo_deduplication_scope" {
  description = "Specifies whether message deduplication occurs at the message group or queue level. (perQueue or perMessageGroupId)"
  type        = string
  default     = null
}

variable "fifo_throughput_limit" {
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group (perQueue or perMessageGroupId)"
  type        = string
  default     = null
}

variable "max_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it"
  type        = string
  default     = "2048"
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200"
  type        = string
  default     = "30"
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900"
  type        = string
  default     = "0"
}

variable "retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  type        = string
  default     = "86400"
}

variable "dlq_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  type        = string
  default     = "259200"
}

variable "wait_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning"
  type        = string
  default     = "10"
}

variable "max_receive_count" {
  description = "Max receive message count"
  type        = string
  default     = "3"
}

variable "principal_roles" {
  description = "A list of IAM roles that a specific principal (user, service, or account) can assume."
  type        = list(string)
  default     = null
}
