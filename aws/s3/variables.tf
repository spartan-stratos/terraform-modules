variable "bucket_name" {
  description = "The bucket name to be created."
  type        = string
  default     = null
}

variable "bucket_prefix" {
  description = "The bucket prefix to be created."
  type        = string
  default     = null
}

variable "object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
  type        = string
  default     = null
}

variable "enabled_cors" {
  description = "Enable to configure the CORS"
  type        = bool
  default     = false
}

variable "cors_configuration" {
  description = "Configuration for CORS settings"
  type = object({
    allowed_headers = optional(list(string))
    expose_headers  = optional(list(string))
    allowed_methods = list(string)
    allowed_origins = list(string)
    max_age_seconds = optional(number)
  })
  default = {
    allowed_headers = []
    expose_headers  = []
    allowed_methods = []
    allowed_origins = []
    max_age_seconds = 3600
  }
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}


variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}


variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}


variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "enabled_public_policy" {
  description = "Enabled create the Public Policy to allow public access to bucket objects."
  type        = bool
  default     = false
}

variable "enabled_read_write_policy" {
  description = "Enabled create the Read Write Policy to allow access to bucket objects."
  type        = bool
  default     = false
}

variable "enabled_read_only_policy" {
  description = "Enabled create the Read Only Policy to allow access to bucket objects."
  type        = bool
  default     = false
}

variable "versioning_status" {
  description = "The status of bucket versioning."
  type        = string
  default     = "Disabled"
}

variable "enabled_iam_policy" {
  description = "Enabled create the IAM Policies."
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "Enable to force destroy the bucket."
  type        = bool
  default     = false
}

variable "acl" {
  description = "Canned ACL to apply to the bucket. Support private and public-read."
  type        = string
  default     = "private"
}

# avoid recreating policies and their dependent resources during migration
variable "read_write_policy_description" {
  description = "Description for read write policy"
  type        = string
  default     = "Policy that allows writing to the S3 bucket"
}

variable "read_write_policy_name_prefix" {
  description = "The name prefix for the read write policy"
  type        = string
  default     = "S3ReadWrite"
}

variable "readonly_policy_description" {
  description = "Description for readonly policy"
  type        = string
  default     = "Policy that allows reading from the s3 assets bucket"
}

variable "readonly_policy_name_prefix" {
  description = "The name prefix for the readonly policy"
  type        = string
  default     = "S3AssetsRead"
}

variable "public_policy_description" {
  description = "Description for public policy"
  type        = string
  default     = "Policy that allows writing to the s3 public assets bucket"
}

variable "public_policy_name_prefix" {
  description = "The name prefix for the public policy"
  type        = string
  default     = "S3PublicAssetsWrite"
}
