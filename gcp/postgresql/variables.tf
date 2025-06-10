variable "project_id" {
  description = "The ID of the project where the GKE will be created."
  type        = string
}

variable "network_name" {
  description = "The name of the network being created."
  type        = string
}

variable "name" {
  description = "The prefix name of the Cloud SQL instance being created."
  type        = string
}

variable "db_name" {
  description = "The name of database being created."
  type        = string
}

variable "region" {
  description = "The GCP Region to use for deployment."
  type        = string
}

variable "size" {
  description = "Start size in GB."
  type        = number
}

variable "tier" {
  description = "Database tier."
  type        = string
  default     = "db-f1-micro"
}

variable "username" {
  description = "The database username to get access."
  type        = string
}

variable "password" {
  description = "The database password to get access."
  type        = string
  default     = null
}

variable "availability_type" {
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL)."
  type        = string
  default     = "ZONAL"
  validation {
    condition     = var.availability_type == "REGIONAL" || var.availability_type == "ZONAL"
    error_message = "Sorry, value must be either 'REGIONAL' or 'ZONAL'."
  }
}

variable "replica_count" {
  description = "The number of Cloud SQL replicas to create."
  type        = number
  default     = 0
}

variable "analytic_replica_count" {
  description = "The number of Cloud SQL analytic replicas to create."
  type        = number
  default     = 0
}

variable "labels" {
  description = "The resource labels to represent user provided metadata."
  type        = map(string)
  default     = {}
}

variable "database_flags" {
  description = "The Cloud SQL instance database flags to create."
  type        = map(string)
  default     = {}
}

variable "enabled_deletion_protection" {
  description = "The boolean to specifies whether deletion protection should be enabled of disabled."
  type        = bool
  default     = true
}

variable "daily_sql_instance_backup_start_time" {
  description = "The start time of daily Cloud SQL instance backup in format 'HH:MM' 24-hour UTC."
  type        = string
  default     = "08:00"
}

variable "retained_backups_count" {
  description = "Depending on the value of retention_unit, this is used to determine if a backup needs to be deleted. If retention_unit is 'COUNT', we will retain this many backups."
  type        = number
  default     = 7
}

variable "transaction_log_retention_days" {
  description = "The number of days of transaction logs we retain for point in time restore, from 1-7 for standard instance."
  type        = number
  default     = 7
}

variable "database_version" {
  description = "The Cloud SQL database version to use."
  type        = string
  default     = "POSTGRES_16"
}

variable "enabled_disk_autoresize" {
  description = "Enables auto-resizing of the storage size. Defaults to true."
  type        = bool
  default     = true
}

variable "master_maintenance_window" {
  description = "Maintenance window configuration for the master instance"
  type = object({
    day          = number
    hour         = number
    update_track = string
  })
  default = {
    day          = 1 # Monday
    hour         = 8 # UTC
    update_track = "stable"
  }

  validation {
    condition     = var.master_maintenance_window.day >= 1 && var.master_maintenance_window.day <= 7
    error_message = "The 'day' attribute for maintenance_window must be between 1 (Monday) and 7 (Sunday)."
  }
  validation {
    condition     = var.master_maintenance_window.hour >= 0 && var.master_maintenance_window.hour <= 23
    error_message = "The 'hour' attribute for maintenance_window must be between 0 and 23 (UTC)."
  }
  validation {
    condition     = contains(["week5", "stable", "canary"], var.master_maintenance_window.update_track)
    error_message = "The 'update_track' attribute for maintenance_window must be either \"week5\", \"stable\" or \"canary\"."
  }
}

variable "replica_maintenance_window" {
  description = "Maintenance window configuration for replica instances"
  type = object({
    day          = number
    hour         = number
    update_track = string
  })
  default = {
    day          = 1 # Monday
    hour         = 8 # UTC
    update_track = "stable"
  }

  validation {
    condition     = var.replica_maintenance_window.day >= 1 && var.replica_maintenance_window.day <= 7
    error_message = "The 'day' attribute for maintenance_window must be between 1 (Monday) and 7 (Sunday)."
  }
  validation {
    condition     = var.replica_maintenance_window.hour >= 0 && var.replica_maintenance_window.hour <= 23
    error_message = "The 'hour' attribute for maintenance_window must be between 0 and 23 (UTC)."
  }
  validation {
    condition     = contains(["week5", "stable", "canary"], var.replica_maintenance_window.update_track)
    error_message = "The 'update_track' attribute for maintenance_window must be either \"week5\", \"stable\" or \"canary\"."
  }
}

variable "analytic_replica_maintenance_window" {
  description = "Maintenance window configuration for analytic replica instances"
  type = object({
    day          = number
    hour         = number
    update_track = string
  })
  default = {
    day          = 1 # Monday
    hour         = 8 # UTC
    update_track = "stable"
  }

  validation {
    condition     = var.analytic_replica_maintenance_window.day >= 1 && var.analytic_replica_maintenance_window.day <= 7
    error_message = "The 'day' attribute for maintenance_window must be between 1 (Monday) and 7 (Sunday)."
  }
  validation {
    condition     = var.analytic_replica_maintenance_window.hour >= 0 && var.analytic_replica_maintenance_window.hour <= 23
    error_message = "The 'hour' attribute for maintenance_window must be between 0 and 23 (UTC)."
  }
  validation {
    condition     = contains(["week5", "stable", "canary"], var.analytic_replica_maintenance_window.update_track)
    error_message = "The 'update_track' attribute for maintenance_window must be either \"week5\", \"stable\" or \"canary\"."
  }
}
