variable "apply_immediately" {
  description = "Enable the feature apply the changes to this database immediately"
  type        = bool
  default     = true
}

variable "backup_window" {
  description = "The time window during which backups will be created."
  type        = string
  default     = "01:00-03:00"
}

variable "instance_class" {
  description = "The Instance Class for the database"
  type        = string
  default     = "db.m5.large"
}

variable "disk_size" {
  description = "The disk size of database instance (in GiB)"
  type        = number
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
  description = "The number of replica for the database."
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

variable "final_snapshot_identifier_prefix" {
  description = "The name which is prefixed to the final snapshot on cluster destroy"
  type        = string
  default     = "final"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter"
  type        = string
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' or gp3. See notes for limitations regarding this variable for gp3"
  type        = number
  default     = null
}

variable "max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  type        = number
  default     = 0
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Specifies whether the RDS instance should be publicly accessible (default is false)."
  type        = bool
  default     = false
}

variable "whitelisted_db_access_cidrs" {
  description = "List of CIDR blocks representing the IP ranges that are permitted to access the database."
  type        = list(string)
  default     = []
}

variable "storage_encryption_enabled" {
  description = "Specifies whether the DB instance is encrypted. Note that if you are creating a cross-region read replica this field is ignored and you should instead declare kms_key_id with a valid ARN. The default is false if not specified."
  type        = bool
  default     = false
}

variable "enabled_auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true."
  type        = bool
  default     = true
}
