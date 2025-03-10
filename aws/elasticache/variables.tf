variable "cluster_name" {
  description = "The name of this cluster"
  type        = string
}

variable "engine_version" {
  description = "The version of Redis, default 7.1"
  type        = string
  default     = "7.1"
}

variable "parameter_group_name" {
  description = "Parameter group for redis cluster, default is 'default.redis7.cluster.on'"
  type        = string
  default     = "default.redis7.cluster.on"
}

variable "multi_az_enabled" {
  description = "Flag to enable multi az feature, default is true"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply changes to the cluster right away or waiting to the next maintenance window, default is true"
  type        = bool
  default     = true
}

variable "automatic_failover_enabled" {
  description = "Automatically promote read-replica to become primary when the primary instance down, default is false"
  type        = bool
  default     = false
}

variable "node_type" {
  description = "The node type of this cluster, will affect the memory and bandwidth"
  type        = string
}

variable "cache_node_count" {
  description = "The number of cache node"
  type        = number
}

variable "subnet_ids" {
  description = "The subnet ids of this cluster"
  type        = list(string)
}

variable "security_group_allow_all_within_vpc_id" {
  description = "The security group allow all connection within vpc id"
  type        = string
}

variable "snapshot_window" {
  description = "The time to do the backup, default 01:00-02:00"
  type        = string
  default     = "01:00-02:00"
}

variable "transit_encryption_enabled" {
  description = "Specifies whether to enable in-transit encryption for the ElastiCache replication group. When set to true, it ensures that data between nodes and clients is encrypted in transit."
  type        = bool
  default     = false
}
