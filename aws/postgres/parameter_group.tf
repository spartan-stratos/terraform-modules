resource "aws_db_parameter_group" "parameter_group" {
  for_each = { for _, version in distinct(concat(var.supported_engine_version, [local.engine_version_major])) : version => version }

  name   = var.custom_parameter_group_name != null ? var.custom_parameter_group_name : "${local.identifier}-${each.key}"
  family = "${var.engine}${each.key}"

  parameter {
    name         = "max_worker_processes"
    value        = lookup(local.max_workers, var.instance_class, 8)
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_parallel_workers"
    value        = lookup(local.max_workers, var.instance_class, 8)
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "rds.logical_replication"
    value        = "1"
    apply_method = "pending-reboot"
  }

  # Params for producer
  parameter {
    name         = "max_wal_senders"
    value        = "10"
    apply_method = "pending-reboot"
  }

  # Params for subscriber
  parameter {
    name         = "max_sync_workers_per_subscription"
    value        = floor(lookup(local.max_workers, var.instance_class, 8) * 0.5)
    apply_method = "immediate"
  }

  # Params for both producer and subscriber
  parameter {
    name         = "max_logical_replication_workers"
    value        = floor(lookup(local.max_workers, var.instance_class, 8) * 0.5)
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_wal_size"
    value        = "10240"
    apply_method = "immediate"
  }

  # see https://www.postgresql.org/docs/14/runtime-config-replication.html#GUC-MAX-REPLICATION-SLOTS
  parameter {
    name         = "max_replication_slots"
    value        = "10"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements,pg_cron,pgaudit"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "pg_stat_statements.track"
    value        = "ALL"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "pg_stat_statements.max"
    value        = "10000"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "track_activity_query_size"
    value        = "4096"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "cron.database_name"
    value        = var.db_name
    apply_method = "pending-reboot"
  }

  lifecycle {
    create_before_destroy = true
  }
}
