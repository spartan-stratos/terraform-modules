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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | \>= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | \>= 5.75 |
| <a name="requirement_random"></a> [random](#requirement\_random) | \>= 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | \>= 5.75 |
| <a name="provider_random"></a> [random](#provider\_random) | \>= 3.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_db_instance"></a> [main\_db\_instance](#module\_main\_db\_instance) | ./db_instance | n/a |
| <a name="module_replica_db_instance"></a> [replica\_db\_instance](#module\_replica\_db\_instance) | ./db_instance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Indicates whether major version upgrades are allowed. | `bool` | `true` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Apply any changes to this database immediately. | `bool` | `true` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates whether minor engine upgrades will be applied automatically to the DB instance during the maintenance window. | `bool` | `false` | no |
| <a name="input_backup_retention_day"></a> [backup\_retention\_day](#input\_backup\_retention\_day) | The number of days to retain database backups (default is 7 days). | `number` | `7` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Indicates whether all instance tags should be copied to snapshots. | `bool` | `true` | no |
| <a name="input_custom_parameter_group_name"></a> [custom\_parameter\_group\_name](#input\_custom\_parameter\_group\_name) | Custom parameter group name, used when `var.overwrite_parameter_group_name` is `true` and `var.supported_engine_version` size is 1. | `string` | `null` | no |
| <a name="input_db_identifier"></a> [db\_identifier](#input\_db\_identifier) | The identifier name of database instance. If null, the db\_name will be used instead. | `string` | `null` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database. | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | The port number on which the database accepts connections. | `number` | `5432` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | The master username for the database. | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The disk size of the database instance, in gigabytes. | `number` | `20` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to be used (e.g., postgres). | `string` | `"postgres"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the database engine to use (default is 16.4). | `string` | `"16.4"` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Enable database authentication using AWS IAM. | `bool` | `false` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class for the database. | `string` | `"db.m5.large"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | The upper limit (in GB) to which Amazon RDS can automatically scale the storage of the DB instance. | `number` | `1000` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval in seconds between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `0` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Indicates whether the database instance should be deployed across multiple availability zones. | `bool` | `false` | no |
| <a name="input_overwrite_parameter_group_name"></a> [overwrite\_parameter\_group\_name](#input\_overwrite\_parameter\_group\_name) | Whether to overwrite parameter group name. | `bool` | `false` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights are enabled for the DB instance. | `bool` | `false` | no |
| <a name="input_port"></a> [port](#input\_port) | The port of the database. | `number` | `5432` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | The number of read replicas for the database. | `number` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Defines whether a final DB snapshot is created before the DB instance is deleted. | `bool` | `true` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Whether the DB instance is encrypted. | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The storage type of the RDS instance (standard, gp2, or gp3). | `string` | `"gp3"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs for the DB subnet group. | `list(string)` | n/a | yes |
| <a name="input_supported_engine_version"></a> [supported\_engine\_version](#input\_supported\_engine\_version) | A list of supported engine versions for the Parameter Groups, supporting Blue-Green deployment. | `list(number)` | <pre>[<br/>  14,<br/>  15,<br/>  16<br/>]</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which the RDS instance will be launched. | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | The list of existing vpc security group ids to associate with database instance. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | The database name. |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | The database password. |
| <a name="output_db_username"></a> [db\_username](#output\_db\_username) | The database username. |
| <a name="output_main_address"></a> [main\_address](#output\_main\_address) | The primary instance hostname. |
| <a name="output_replica_address"></a> [replica\_address](#output\_replica\_address) | The replica hostname, fallback to the hostname of main instance if there is no replica. |
<!-- END_TF_DOCS -->