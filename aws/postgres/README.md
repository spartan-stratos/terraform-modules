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

  db_name                                = "example_rds"
  db_username                            = "exampleuser"
  instance_class                         = "db.t3.micro"
  disk_size                              = 10
  iam_database_authentication_enabled    = false
  replica_count                          = 0
  security_group_allow_all_within_vpc_id = "sg-1234567899"
  subnet_ids                             = []
  postgresql_password_secret_id          = "secret-123456789"
  storage_type                           = "gp3"
  enabled_auto_minor_version_upgrade     = false
}
```

## Examples
- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version  |
|------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | \>= 5.75 |

## Providers

| Name | Version  |
|------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | \>= 5.75 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_secretsmanager_secret_version.postgresql_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name                                                                                                                                                             | Description                                                                                                                                                                                                                                                                                | Type           | Default                       | Required |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|-------------------------------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately)                                                                          | Enable the feature apply the changes to this database immediately                                                                                                                                                                                                                          | `bool`         | `true`                        |    no    |
| <a name="input_backup_retention_day"></a> [backup\_retention\_day](#input\_backup\_retention\_day)                                                               | Backup retention day, default 7 days                                                                                                                                                                                                                                                       | `number`       | `7`                           |    no    |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window)                                                                                      | The time for this db will create backup                                                                                                                                                                                                                                                    | `string`       | `"01:00-03:00"`               |    no    |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name)                                                                                                        | The name of the database                                                                                                                                                                                                                                                                   | `string`       | n/a                           |   yes    |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port)                                                                                                        | The port of the database                                                                                                                                                                                                                                                                   | `number`       | `5432`                        |    no    |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username)                                                                                            | The username of the database                                                                                                                                                                                                                                                               | `string`       | n/a                           |   yes    |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size)                                                                                                  | The disk size of database instance                                                                                                                                                                                                                                                         | `number`       | n/a                           |   yes    |
| <a name="input_enabled_auto_minor_version_upgrade"></a> [enabled\_auto\_minor\_version\_upgrade](#input\_enabled\_auto\_minor\_version\_upgrade)                 | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true.                                                                                                                                                     | `bool`         | n/a                           |   yes    |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version)                                                                                   | The version of Postgres database, default 14.9                                                                                                                                                                                                                                             | `string`       | `"16.4"`                      |    no    |
| <a name="input_final_snapshot_identifier_prefix"></a> [final\_snapshot\_identifier\_prefix](#input\_final\_snapshot\_identifier\_prefix)                         | The name which is prefixed to the final snapshot on cluster destroy                                                                                                                                                                                                                        | `string`       | `"final"`                     |    no    |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled)                | Enable database authentication with iam                                                                                                                                                                                                                                                    | `bool`         | n/a                           |   yes    |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class)                                                                                   | The Instance Class for the database                                                                                                                                                                                                                                                        | `string`       | `"db.m5.large"`               |    no    |
| <a name="input_iops"></a> [iops](#input\_iops)                                                                                                                   | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1' or gp3. See notes for limitations regarding this variable for gp3                                                                                                                                            | `number`       | `null`                        |    no    |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage)                                                            | Specifies the value for Storage Autoscaling                                                                                                                                                                                                                                                | `number`       | `0`                           |    no    |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval)                                                                    | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60                                                         | `number`       | `0`                           |    no    |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az)                                                                                                     | Allow this db run on multi available zone                                                                                                                                                                                                                                                  | `bool`         | `false`                       |    no    |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled)                                       | Specifies whether Performance Insights are enabled                                                                                                                                                                                                                                         | `bool`         | `false`                       |    no    |
| <a name="input_postgresql_password_secret_id"></a> [postgresql\_password\_secret\_id](#input\_postgresql\_password\_secret\_id)                                  | The secret id of the password for the database                                                                                                                                                                                                                                             | `string`       | n/a                           |   yes    |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible)                                                                    | Specifies whether the RDS instance should be publicly accessible (default is false).                                                                                                                                                                                                       | `bool`         | false                         |    no     |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count)                                                                                      | The number of replica db                                                                                                                                                                                                                                                                   | `number`       | n/a                           |   yes    |
| <a name="input_security_group_allow_all_within_vpc_id"></a> [security\_group\_allow\_all\_within\_vpc\_id](#input\_security\_group\_allow\_all\_within\_vpc\_id) | The security group allow all connection within vpc id                                                                                                                                                                                                                                      | `string`       | n/a                           |   yes    |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot)                                                                  | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted                                                                     | `bool`         | `false`                       |    no    |
| <a name="input_storage_encryption_enabled"></a> [storage\_encryption\_enabled](#input\_storage\_encryption\_enabled)                                             | Specifies whether the DB instance is encrypted. Note that if you are creating a cross-region read replica this field is ignored and you should instead declare kms_key_id with a valid ARN. The default is false if not specified.                                                         | `bool`         | `false`                       |    no    |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type)                                                                                         | One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter | `string`       | n/a                           |   yes    |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids)                                                                                               | The subnet ids of this cluster                                                                                                                                                                                                                                                             | `list(string)` | n/a                           |   yes    |
| <a name="input_supported_engine_version"></a> [supported\_engine\_version](#input\_supported\_engine\_version)                                                   | The supported engine version to create the Parameter Groups (support Blue-Green Deployment)                                                                                                                                                                                                | `list(string)` | <pre>[<br/>  "16"<br/>]</pre> |    no    |

## Outputs

| Name                                                                                | Description                                                                                                             |
|-------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------|
| <a name="output_db_identifier"></a> [db\_identifier](#output\_db\_identifier)       | The database identifier.                                                                                                |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password)             | The database password.                                                                                                  |
| <a name="output_jdbc_url"></a> [jdbc\_url](#output\_jdbc\_url)                      | The JDBC format URL of primary RDS instance.                                                                            |
| <a name="output_main_address"></a> [main\_address](#output\_main\_address)          | The address of the main database instance. This is used for direct connections to the primary database instance.        |
| <a name="output_main_endpoint"></a> [main\_endpoint](#output\_main\_endpoint)       | The endpoint of primary database instance in address:port format.                                                       |
| <a name="output_main_db_name"></a> [main\_db\_name](#output\_main\_db\_name)        | The database name of the main database instance. This is used to identify the database when connecting to the instance. |
| <a name="output_replica_address"></a> [replica\_address](#output\_replica\_address) | The endpoint of the first replica, fallback to the endpoint of the main instance if there is no replica.                |
<!-- END_TF_DOCS -->
