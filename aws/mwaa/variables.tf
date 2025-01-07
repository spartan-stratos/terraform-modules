#----------------------------------------------------------------
# MWAA Environment
#----------------------------------------------------------------
variable "name" {
  description = "(Required) The name of the Apache Airflow MWAA Environment"
  type        = string
}

variable "private_subnet_ids" {
  description = <<-EOD
  (Required) The private subnet IDs in which the environment should be created.
  MWAA requires two subnets.
  EOD
  type        = list(string)
}

variable "airflow_configuration_options" {
  description = "(Optional) The airflow_configuration_options parameter specifies airflow override options."
  type        = any
  default     = null
}

variable "airflow_version" {
  description = "(Optional) Airflow version of your environment, will be set by default to the latest version that MWAA supports."
  type        = string
  default     = null
}

variable "dag_s3_path" {
  description = "(Required) The relative path to the DAG folder on your Amazon S3 storage bucket. For example, dags."
  type        = string
  default     = "dags"
}

variable "environment_class" {
  description = <<-EOD
  (Optional) Environment class for the cluster. Possible options are mw1.small, mw1.medium, mw1.large, mw1.xlarge, mw1.2xlarge.
  Will be set by default to mw1.small. Please check the AWS Pricing for more information about the environment classes.
  EOD
  type        = string
  default     = "mw1.small"

  validation {
    condition     = contains(["mw1.small", "mw1.medium", "mw1.large", "mw1.xlarge", "mw1.2xlarge"], var.environment_class)
    error_message = "Invalid input, options: \"mw1.small\", \"mw1.medium\", \"mw1.large\", \"mw1.xlarge\", \"mw1.2xlarge\"."
  }
}

variable "kms_key" {
  description = <<-EOD
  (Optional) The Amazon Resource Name (ARN) of your KMS key that you want to use for encryption.
  Will be set to the ARN of the managed KMS key aws/airflow by default.
  EOD
  type        = string
  default     = null
}

variable "logging_configuration" {
  description = "(Optional) The Apache Airflow logs which will be send to Amazon CloudWatch Logs."
  type        = any
  default     = null
}

variable "max_workers" {
  description = <<-EOD
  (Optional) The maximum number of workers that can be automatically scaled up.
  Value need to be between 1 and 25. Will be 10 by default
  EOD
  type        = number
  default     = 10

  validation {
    condition     = var.max_workers > 0 && var.max_workers < 26
    error_message = "Error: Value need to be between 1 and 25."
  }
}

variable "min_workers" {
  description = "(Optional) The minimum number of workers that you want to run in your environment. Will be 1 by default."
  type        = number
  default     = 1
}

variable "plugins_s3_object_version" {
  description = "(Optional) The plugins.zip file version you want to use."
  type        = string
  default     = null
}

variable "plugins_s3_path" {
  description = "(Optional) The relative path to the plugins.zip file on your Amazon S3 storage bucket. For example, plugins.zip. If a relative path is provided in the request, then plugins_s3_object_version is required."
  type        = string
  default     = null
}

variable "requirements_s3_object_version" {
  description = "(Optional) The requirements.txt file version you want to use."
  type        = string
  default     = null
}

variable "requirements_s3_path" {
  description = "(Optional) The relative path to the requirements.txt file on your Amazon S3 storage bucket. For example, requirements.txt. If a relative path is provided in the request, then requirements_s3_object_version is required."
  type        = string
  default     = null
}

variable "startup_script_s3_object_version" {
  description = "(Optional) The version of the startup shell script you want to use. You must specify the version ID that Amazon S3 assigns to the file every time you update the script."
  type        = string
  default     = null
}

variable "startup_script_s3_path" {
  description = "(Optional) The relative path to the script hosted in your bucket. The script runs as your environment starts before starting the Apache Airflow process. Use this script to install dependencies, modify configuration options, and set environment variables."
  type        = string
  default     = null
}

variable "schedulers" {
  description = "(Optional) The number of schedulers that you want to run in your environment."
  type        = string
  default     = null
}

variable "webserver_access_mode" {
  description = "(Optional) Specifies whether the webserver should be accessible over the internet or via your specified VPC. Possible options: PRIVATE_ONLY (default) and PUBLIC_ONLY"
  type        = string
  default     = "PRIVATE_ONLY"

  validation {
    condition     = contains(["PRIVATE_ONLY", "PUBLIC_ONLY"], var.webserver_access_mode)
    error_message = "Invalid input, options: \"PRIVATE_ONLY\", \"PUBLIC_ONLY\"."
  }
}

variable "weekly_maintenance_window_start" {
  description = "(Optional) Specifies the start date for the weekly maintenance window"
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A map of resource tags to associate with the resource"
  type        = map(string)
  default     = {}
}

#----------------------------------------------------------------
# MWAA S3 Bucket
#----------------------------------------------------------------
variable "create_s3_bucket" {
  description = "Create new S3 bucket for MWAA. "
  type        = string
  default     = true
}

variable "source_bucket_name" {
  description = <<-EOD
  New bucket will be created with the given name for MWAA when create_s3_bucket=true.
  If set to null, then the default bucket name prefix will be set, irrespective of the value of `var.use_source_bucket_name_as_prefix`
  EOD
  type        = string
  default     = null
}

variable "source_bucket_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of your Amazon S3 storage bucket. For example, arn:aws:s3:::airflow-mybucketname"
  type        = string
  default     = null
}

#----------------------------------------------------------------
# MWAA IAM Role
#----------------------------------------------------------------
variable "create_iam_role" {
  description = "Create IAM role for MWAA"
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "IAM Role Name to be created if execution_role_arn is null"
  type        = string
  default     = null
}

variable "additional_principal_arns" {
  description = "List of additional AWS principal ARNs"
  type        = list(string)
  default     = []
}

variable "iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM role"
  type        = map(string)
  default     = {}
}

variable "execution_role_arn" {
  description = <<-EOD
  (Required) The Amazon Resource Name (ARN) of the task execution role that the Amazon MWAA and its environment can assume
  Mandatory if `create_iam_role=false`
  EOD
  type        = string
  default     = null
}

#----------------------------------------------------------------
# MWAA Security groups
#----------------------------------------------------------------
variable "security_group_ids" {
  description = "Security group IDs for MWAA"
  type        = list(string)
  default     = []
}