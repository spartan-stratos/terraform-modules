variable "apply_immediately" {
  description = "Enable the feature apply the changes to this database immediately"
  type        = bool
  default     = true
}

variable "backup_window" {
  description = "The time for this db will create backup"
  type        = string
  default     = "01:00-03:00"
}

variable "instance_class" {
  description = "The Instance Class for the database"
  type        = string
  default     = "db.m5.large"
}

variable "environment" {
  description = "The environment of this database"
  type        = string
}

variable "disk_size" {
  description = "The disk size of database instance"
  type        = number
}

variable "db_identifier" {
  description = "The database identifier"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username of the database"
  type        = string
}

variable "db_port" {
  description = "The port of the database"
  type        = number
  default     = 5432
}

variable "subnet_ids" {
  description = "The subnet ids of this cluster"
  type        = list(string)
}

variable "backup_retention_day" {
  description = "Backup retention day, default 7 days"
  type        = number
  default     = 7
}

variable "multi_az" {
  description = "Allow this db run on multi available zone"
  type        = bool
  default     = false
}

variable "iam_database_authentication_enabled" {
  description = "Enable database authentication with iam"
  type        = bool
}

variable "engine_version" {
  description = "The version of Postgres database, default 14.9"
  type        = string
  default     = "16.4"
}

variable "security_group_allow_all_within_vpc_id" {
  description = "The security group allow all connection within vpc id"
  type        = string
}

variable "replica_count" {
  description = "The number of replica db"
  type        = number
}

variable "postgresql_password_secret_id" {
  description = "The secret id of the password for the database"
  type        = string
}

variable "supported_engine_version" {
  description = "The supported engine version to create the Parameter Groups (support Blue-Green Deployment)"
  type        = list(string)
  default     = ["16"]
}
