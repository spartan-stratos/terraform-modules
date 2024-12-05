# AWS RDS PostgreSQL Terraform module

Terraform module which creates RDS PostgreSQL resources on AWS.

This module will create the following components:

- A main PostgreSQL RDS instance, we can also specify whether create RDS replicas for the master one
- The parameter group for RDS can be configured and viewed in the `parameter_group.tf` file

## Usage

### Create RDS PostgreSQL

```hcl
module "instance" {
  source  = "github.com/spartan-stratos/terraform-modules//aws/postgres?ref=v0.1.0"

  db_name                             = "example_rds"
  db_username                         = "exampleuser"
  instance_class                      = "db.t3.micro"
  disk_size                           = 10
  iam_database_authentication_enabled = false
  replica_count                       = 0
  vpc_id                              = "vpc-123456789"
  subnet_ids                          = []
  storage_type                        = "gp3"
}
```

## Examples

- [Example](./examples/complete/)

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 5.75  |

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)          | >= 5.75 |
| <a name="provider_random"></a> [random](#provider_random) | n/a     |

## Modules

| Name                                                                                         | Source        | Version |
| -------------------------------------------------------------------------------------------- | ------------- | ------- |
| <a name="module_main_db_instance"></a> [main_db_instance](#module_main_db_instance)          | ./db_instance | n/a     |
| <a name="module_replica_db_instance"></a> [replica_db_instance](#module_replica_db_instance) | ./db_instance | n/a     |

## Resources

| Name                                                                                                                                                    | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_db_parameter_group.parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group)                | resource    |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)                                 | resource    |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                   | resource    |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule)   | resource    |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource    |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)                                         | resource    |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc)                                                      | data source |

## Inputs

| Name                                                                                                                                       | Description                                                                                                             | Type           | Default                                  | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- | -------------- | ---------------------------------------- | :------: |
| <a name="input_allow_major_version_upgrade"></a> [allow_major_version_upgrade](#input_allow_major_version_upgrade)                         | Indicates whether major version upgrades are allowed.                                                                   | `bool`         | `true`                                   |    no    |
| <a name="input_apply_immediately"></a> [apply_immediately](#input_apply_immediately)                                                       | Apply any changes to this database immediately.                                                                         | `bool`         | `true`                                   |    no    |
| <a name="input_auto_minor_version_upgrade"></a> [auto_minor_version_upgrade](#input_auto_minor_version_upgrade)                            | Indicates whether minor engine upgrades will be applied automatically to the DB instance during the maintenance window. | `bool`         | `false`                                  |    no    |
| <a name="input_backup_retention_day"></a> [backup_retention_day](#input_backup_retention_day)                                              | The number of days to retain database backups (default is 7 days).                                                      | `number`       | `7`                                      |    no    |
| <a name="input_copy_tags_to_snapshot"></a> [copy_tags_to_snapshot](#input_copy_tags_to_snapshot)                                           | Indicates whether all instance tags should be copied to snapshots.                                                      | `bool`         | `true`                                   |    no    |
| <a name="input_db_name"></a> [db_name](#input_db_name)                                                                                     | The name of the database.                                                                                               | `string`       | n/a                                      |   yes    |
| <a name="input_db_port"></a> [db_port](#input_db_port)                                                                                     | The port number on which the database accepts connections.                                                              | `number`       | `5432`                                   |    no    |
| <a name="input_db_username"></a> [db_username](#input_db_username)                                                                         | The master username for the database.                                                                                   | `string`       | n/a                                      |   yes    |
| <a name="input_disk_size"></a> [disk_size](#input_disk_size)                                                                               | The disk size of the database instance, in gigabytes.                                                                   | `number`       | `20`                                     |    no    |
| <a name="input_engine"></a> [engine](#input_engine)                                                                                        | The database engine to be used (e.g., postgres).                                                                        | `string`       | `"postgres"`                             |    no    |
| <a name="input_engine_version"></a> [engine_version](#input_engine_version)                                                                | The version of the database engine to use (default is 16.4).                                                            | `string`       | `"16.4"`                                 |    no    |
| <a name="input_iam_database_authentication_enabled"></a> [iam_database_authentication_enabled](#input_iam_database_authentication_enabled) | Enable database authentication using AWS IAM.                                                                           | `bool`         | `false`                                  |    no    |
| <a name="input_instance_class"></a> [instance_class](#input_instance_class)                                                                | The instance class for the database.                                                                                    | `string`       | `"db.m5.large"`                          |    no    |
| <a name="input_max_allocated_storage"></a> [max_allocated_storage](#input_max_allocated_storage)                                           | The upper limit (in GB) to which Amazon RDS can automatically scale the storage of the DB instance.                     | `number`       | `1000`                                   |    no    |
| <a name="input_monitoring_interval"></a> [monitoring_interval](#input_monitoring_interval)                                                 | The interval in seconds between points when Enhanced Monitoring metrics are collected for the DB instance.              | `number`       | `0`                                      |    no    |
| <a name="input_multi_az"></a> [multi_az](#input_multi_az)                                                                                  | Indicates whether the database instance should be deployed across multiple availability zones.                          | `bool`         | `false`                                  |    no    |
| <a name="input_performance_insights_enabled"></a> [performance_insights_enabled](#input_performance_insights_enabled)                      | Specifies whether Performance Insights are enabled for the DB instance.                                                 | `bool`         | `false`                                  |    no    |
| <a name="input_port"></a> [port](#input_port)                                                                                              | The port of the database.                                                                                               | `number`       | `5432`                                   |    no    |
| <a name="input_replica_count"></a> [replica_count](#input_replica_count)                                                                   | The number of read replicas for the database.                                                                           | `number`       | n/a                                      |   yes    |
| <a name="input_skip_final_snapshot"></a> [skip_final_snapshot](#input_skip_final_snapshot)                                                 | Defines whether a final DB snapshot is created before the DB instance is deleted.                                       | `bool`         | `true`                                   |    no    |
| <a name="input_storage_encrypted"></a> [storage_encrypted](#input_storage_encrypted)                                                       | Whether the DB instance is encrypted.                                                                                   | `bool`         | `true`                                   |    no    |
| <a name="input_storage_type"></a> [storage_type](#input_storage_type)                                                                      | The storage type of the RDS instance (standard, gp2, or gp3).                                                           | `string`       | `"gp3"`                                  |    no    |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids)                                                                            | A list of subnet IDs for the DB subnet group.                                                                           | `list(string)` | n/a                                      |   yes    |
| <a name="input_supported_engine_version"></a> [supported_engine_version](#input_supported_engine_version)                                  | A list of supported engine versions for the Parameter Groups, supporting Blue-Green deployment.                         | `list(number)` | <pre>[<br> 14,<br> 15,<br> 16<br>]</pre> |    no    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                                                                        | The ID of the VPC in which the RDS instance will be launched.                                                           | `string`       | n/a                                      |   yes    |

## Outputs

| Name                                                                             | Description                                                                                         |
| -------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| <a name="output_db_name"></a> [db_name](#output_db_name)                         | The database name                                                                                   |
| <a name="output_db_password"></a> [db_password](#output_db_password)             | n/a                                                                                                 |
| <a name="output_db_username"></a> [db_username](#output_db_username)             | n/a                                                                                                 |
| <a name="output_main_address"></a> [main_address](#output_main_address)          | The address of the main instance                                                                    |
| <a name="output_replica_address"></a> [replica_address](#output_replica_address) | The endpoint of the first replica, fallback to the endpoint of main instance if there is no replica |
