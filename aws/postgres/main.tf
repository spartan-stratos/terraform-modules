resource "random_password" "this" {
  length  = 24
  special = false
}

data "aws_vpc" "this" {
  id = var.vpc_id
}

resource "aws_db_subnet_group" "this" {
  description = local.db_subnet_group_description
  name        = local.db_subnet_group_name
  subnet_ids  = var.subnet_ids
}

resource "aws_security_group" "this" {
  count = var.vpc_security_group_ids == null ? 1 : 0

  name        = "Allow ${local.identifier} RDS"
  description = "Allow RDS inbound traffic and outbound traffic inside the VPC"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  count = var.vpc_security_group_ids == null ? 1 : 0

  security_group_id = aws_security_group.this[0].id
  cidr_ipv4         = data.aws_vpc.this.cidr_block
  from_port         = var.port
  ip_protocol       = "tcp"
  to_port           = var.port
}

resource "aws_vpc_security_group_egress_rule" "this" {
  count = var.vpc_security_group_ids == null ? 1 : 0

  security_group_id = aws_security_group.this[0].id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

module "main_db_instance" {
  source                       = "./db_instance"
  identifier                   = local.identifier
  instance_class               = var.instance_class
  allocated_storage            = var.disk_size
  max_allocated_storage        = var.max_allocated_storage
  backup_retention_period      = local.default_backup_retention
  skip_final_snapshot          = var.skip_final_snapshot
  storage_type                 = var.storage_type
  storage_encrypted            = var.storage_encrypted
  engine                       = var.engine
  engine_version               = var.engine_version
  username                     = var.db_username
  password                     = random_password.this.result
  db_name                      = var.db_name
  db_subnet_group_name         = aws_db_subnet_group.this.name
  vpc_security_group_ids       = local.vpc_security_group_ids
  allow_major_version_upgrade  = var.allow_major_version_upgrade
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  apply_immediately            = var.apply_immediately
  monitoring_interval          = var.monitoring_interval
  performance_insights_enabled = var.performance_insights_enabled
  parameter_group_name         = aws_db_parameter_group.parameter_group[local.engine_version_major].id
  publicly_accessible          = false
  final_snapshot_identifier    = local.db_final_snapshot_identifier
  copy_tags_to_snapshot        = var.copy_tags_to_snapshot
}

module "replica_db_instance" {
  source                       = "./db_instance"
  count                        = var.replica_count
  identifier                   = "${local.identifier}-replica-${count.index}"
  instance_class               = var.instance_class
  allocated_storage            = var.disk_size
  max_allocated_storage        = var.max_allocated_storage
  backup_retention_period      = "0"
  skip_final_snapshot          = var.skip_final_snapshot
  storage_type                 = var.storage_type
  storage_encrypted            = var.storage_encrypted
  engine                       = var.engine
  engine_version               = var.engine_version
  vpc_security_group_ids       = local.vpc_security_group_ids
  allow_major_version_upgrade  = var.allow_major_version_upgrade
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  apply_immediately            = var.apply_immediately
  monitoring_interval          = var.monitoring_interval
  performance_insights_enabled = var.performance_insights_enabled
  parameter_group_name         = aws_db_parameter_group.parameter_group[local.engine_version_major].id
  publicly_accessible          = false
  replicate_source_db          = module.main_db_instance.db_identifier
  copy_tags_to_snapshot        = var.copy_tags_to_snapshot
}
