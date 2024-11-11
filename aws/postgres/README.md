# AWS RDS PostgreSQL Terraform module
Terraform module which creates RDS PostgreSQL resources on AWS.

This module will create the following components:
- A main PostgreSQL RDS instance, we can also specify whether create RDS replicas for the master one
- The parameter group for RDS can be configured and viewed in the `parameter_group.tf` file

## Usage
### Create RDS PostgreSQL
```hcl
module "instance" {
  source  = "c0x12c/postgres/aws"
  version = "~> 1.0"

  db_identifier                          = "example-rds"
  db_name                                = "example_rds"
  db_username                            = "exampleuser"
  instance_class                         = "db.t3.micro"
  disk_size                              = 10
  environment                            = "dev"
  iam_database_authentication_enabled    = false
  replica_count                          = 0
  security_group_allow_all_within_vpc_id = "sg-1234567899"
  subnet_ids                             = []
  postgresql_password_secret_id          = "secret-123456789"
}
```

## Examples
- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.46 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.46 |

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

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Enable the feature apply the changes to this database immediately | `bool` | `true` | no |
| <a name="input_backup_retention_day"></a> [backup\_retention\_day](#input\_backup\_retention\_day) | Backup retention day, default 7 days | `number` | `7` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The time for this db will create backup | `string` | `"01:00-03:00"` | no |
| <a name="input_db_identifier"></a> [db\_identifier](#input\_db\_identifier) | The database identifier | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | The port of the database | `number` | `5432` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | The username of the database | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The disk size of database instance | `number` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of Postgres database, default 14.9 | `string` | `"16.4"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment of this database | `string` | n/a | yes |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Enable database authentication with iam | `bool` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The Instance Class for the database | `string` | `"db.m5.large"` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Allow this db run on multi available zone | `bool` | `false` | no |
| <a name="input_postgresql_password_secret_id"></a> [postgresql\_password\_secret\_id](#input\_postgresql\_password\_secret\_id) | The secret id of the password for the database | `string` | n/a | yes |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | The number of replica db | `number` | n/a | yes |
| <a name="input_security_group_allow_all_within_vpc_id"></a> [security\_group\_allow\_all\_within\_vpc\_id](#input\_security\_group\_allow\_all\_within\_vpc\_id) | The security group allow all connection within vpc id | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet ids of this cluster | `list(string)` | n/a | yes |
| <a name="input_supported_engine_version"></a> [supported\_engine\_version](#input\_supported\_engine\_version) | The supported engine version to create the Parameter Groups (support Blue-Green Deployment) | `list(string)` | <pre>[<br/>  "16"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_main_address"></a> [main\_address](#output\_main\_address) | The address of the main database instance. This is used for direct connections to the primary database instance. |
| <a name="output_main_db_name"></a> [main\_db\_name](#output\_main\_db\_name) | The database name of the main database instance. This is used to identify the database when connecting to the instance. |
| <a name="output_replica_address"></a> [replica\_address](#output\_replica\_address) | The endpoint of the first replica, fallback to the endpoint of the main instance if there is no replica. |
<!-- END_TF_DOCS -->