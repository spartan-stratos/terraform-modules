locals {
  engine_version_major = var.engine == "postgres" ? tostring(parseint(split(".", var.engine_version)[0], 10)) : var.engine_version
  identifier           = replace(var.db_name, "_", "-")
  max_workers = {
    "db.m5.4xlarge"  = 16
    "db.m5.12xlarge" = 48
    "db.m5.24xlarge" = 96
    "db.r5.4xlarge"  = 16
    "db.r5.12xlarge" = 48
    "db.r5.24xlarge" = 96
  }
  db_subnet_group_description  = "${var.db_name} db subnet group"
  db_subnet_group_name         = "${var.db_name}-subnet"
  default_backup_retention     = var.backup_retention_day
  db_final_snapshot_identifier = "${local.identifier}-${formatdate("HH-mmaa", timestamp())}"
}
