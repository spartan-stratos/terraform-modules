# Basic configuration
variable "db_name" {
  description = "The name of the database."
  type        = string
}

variable "db_identifier" {
  description = "The identifier name of database instance. If null, the db_name will be used instead."
  type        = string
  default     = null
}

variable "db_username" {
  description = "The master username for the database."
  type        = string
}

variable "instance_class" {
  description = "The instance class for the database."
  type        = string
  default     = "db.m5.large"
}

variable "disk_size" {
  description = "The disk size of the database instance, in gigabytes."
  type        = number
  default     = 20
}

variable "engine" {
  description = "The database engine to be used (e.g., postgres)."
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The version of the database engine to use (default is 16.4)."
  type        = string
  default     = "16.4"
}

variable "port" {
  description = "The port of the database."
  type        = number
  default     = 5432
}

variable "storage_type" {
  description = "The storage type of the RDS instance (standard, gp2, or gp3)."
  type        = string
  default     = "gp3"
}

variable "vpc_id" {
  description = "The ID of the VPC in which the RDS instance will be launched."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the DB subnet group."
  type        = list(string)
}

variable "db_port" {
  description = "The port number on which the database accepts connections."
  type        = number
  default     = 5432
}

variable "multi_az" {
  description = "Indicates whether the database instance should be deployed across multiple availability zones."
  type        = bool
  default     = false
}

# Security
variable "storage_encrypted" {
  description = "Whether the DB instance is encrypted."
  type        = bool
  default     = true
}

variable "iam_database_authentication_enabled" {
  description = "Enable database authentication using AWS IAM."
  type        = bool
  default     = false
}

# Backup and retention
variable "backup_retention_day" {
  description = "The number of days to retain database backups (default is 7 days)."
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  description = "Defines whether a final DB snapshot is created before the DB instance is deleted."
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "Indicates whether all instance tags should be copied to snapshots."
  type        = bool
  default     = true
}

# Performance and scaling
variable "max_allocated_storage" {
  description = "The upper limit (in GB) to which Amazon RDS can automatically scale the storage of the DB instance."
  type        = number
  default     = 1000
}

variable "monitoring_interval" {
  description = "The interval in seconds between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = 0
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled for the DB instance."
  type        = bool
  default     = false
}

# Upgrades
variable "allow_major_version_upgrade" {
  description = "Indicates whether major version upgrades are allowed."
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Indicates whether minor engine upgrades will be applied automatically to the DB instance during the maintenance window."
  type        = bool
  default     = false
}

# Replica and other configurations
variable "apply_immediately" {
  description = "Apply any changes to this database immediately."
  type        = bool
  default     = true
}

variable "replica_count" {
  description = "The number of read replicas for the database."
  type        = number
}

variable "supported_engine_version" {
  description = "A list of supported engine versions for the Parameter Groups, supporting Blue-Green deployment."
  type        = list(number)
  default     = [14, 15, 16]
}
