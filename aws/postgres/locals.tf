locals {
  engine_version_major = parseint(split(".", var.engine_version)[0], 10)
  # RDS identifier accepts only lowercase alphanumeric characters and hyphens
  identifier = replace(var.db_name, "_", "-")
  postgres_max_workers = {
    "db.m5.4xlarge"  = 16
    "db.m5.12xlarge" = 48
    "db.m5.24xlarge" = 96
    "db.r5.4xlarge"  = 16
    "db.r5.12xlarge" = 48
    "db.r5.24xlarge" = 96
  }
}
