/*
aws_db_subnet_group this creates a subnet group for the RDS instance.
The subnet group is used to specify which subnets the RDS instance will be deployed in.
The `subnet_ids` variable is used to pass the list of subnet IDs to the resource.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
*/
resource "aws_db_subnet_group" "this" {
  description = "${var.db_name} db subnet group"
  name        = "${var.db_name}-subnet"
  subnet_ids  = var.subnet_ids
}

/*
aws_secretsmanager_secret_version postgresql_password retrieves the version of a secret from AWS Secrets Manager.
This secret is used to store the PostgreSQL database password securely.
The `postgresql_password_secret_id` variable is used to pass the secret's ID to the data source.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version
*/
data "aws_secretsmanager_secret_version" "postgresql_password" {
  secret_id = var.postgresql_password_secret_id
}

/*
aws_db_instance main creates an RDS PostgreSQL instance in the specified VPC and subnet group.
It is configured with backup, storage, performance, and security options, such as multi-AZ and encryption.
The database password is retrieved from AWS Secrets Manager.
The `apply_immediately` variable is used to specify if changes should be applied immediately.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
*/
resource "aws_db_instance" "main" {
  depends_on = [
    aws_db_subnet_group.this,
    aws_db_parameter_group.parameter_group
  ]

  identifier              = var.db_identifier
  instance_class          = var.instance_class
  allocated_storage       = var.disk_size
  max_allocated_storage   = var.max_allocated_storage
  backup_window           = var.backup_window
  backup_retention_period = var.backup_retention_day
  db_name                 = var.db_name
  engine                  = "postgres"
  engine_version          = var.engine_version
  username                = var.db_username
  password                = data.aws_secretsmanager_secret_version.postgresql_password.secret_string
  port                    = var.db_port
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids = [
    var.security_group_allow_all_within_vpc_id
  ]

  # optional
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = false
  apply_immediately           = var.apply_immediately

  copy_tags_to_snapshot = true
  multi_az              = var.multi_az
  storage_type          = var.storage_type
  iops                  = var.iops

  storage_encrypted = true

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  parameter_group_name                = aws_db_parameter_group.parameter_group[local.engine_version_major].id
  publicly_accessible                 = false

  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.final_snapshot_identifier_prefix}-${local.identifier}-${formatdate("HH-mmaa", timestamp())}"
  skip_final_snapshot       = var.skip_final_snapshot

  monitoring_interval = var.monitoring_interval

  performance_insights_enabled = var.performance_insights_enabled

  timeouts {
    create = "2h"
    update = "2h"
    delete = "2h"
  }
}

/*
aws_db_instance replica creates read replicas for the RDS PostgreSQL instance.
The replicas are configured to replicate from the main instance and are created in the specified VPC.
It is set up to skip final snapshot creation and does not enable backups for the replicas.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
*/
resource "aws_db_instance" "replica" {
  instance_class        = var.instance_class
  replicate_source_db   = aws_db_instance.main.identifier
  count                 = var.replica_count
  allocated_storage     = var.disk_size
  max_allocated_storage = var.max_allocated_storage

  identifier = "${var.db_identifier}-replica-${count.index}"

  backup_retention_period = "0"

  skip_final_snapshot = "true"
  storage_type        = var.storage_type
  iops                = var.iops

  storage_encrypted = true

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  parameter_group_name                = aws_db_parameter_group.parameter_group[local.engine_version_major].id
  publicly_accessible                 = false

  vpc_security_group_ids = [
    var.security_group_allow_all_within_vpc_id,
  ]

  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = false
  apply_immediately           = var.apply_immediately

  monitoring_interval = var.monitoring_interval

  performance_insights_enabled = var.performance_insights_enabled
}
