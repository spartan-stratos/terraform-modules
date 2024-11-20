# AWS Elasticache Terraform module
Terraform module which creates Elasticache resources on AWS.

This module will create the following components:
- The ElastiCache subnet groups
- The ElastiCache replication group 

## Usage
### Create Elasticache
```hcl
module "elasticache" {
  source  = "c0x12c/elasticache/aws"
  version = "~> 1.0"

  cluster_name                           = "example"
  environment                            = "dev"
  subnet_ids                             = ["subnet-1234567899a", "subnet-1234567899b"]
  node_type                              = "cache.t3.micro"
  cache_node_count                       = 1
  security_group_allow_all_within_vpc_id = "sg-1234567899"
}
```

## Examples
- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.75 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_replication_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Apply changes to the cluster right away or waiting to the next maintenance window, default is true | `bool` | `true` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | Automatically promote read-replica to become primary when the primary instance down, default is false | `bool` | `false` | no |
| <a name="input_cache_node_count"></a> [cache\_node\_count](#input\_cache\_node\_count) | The number of cache node | `number` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of this cluster | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of Redis, default 7.1 | `string` | `"7.1"` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | Flag to enable multi az feature, default is true | `bool` | `false` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The node type of this cluster, will affect the memory and bandwidth | `string` | n/a | yes |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Parameter group for redis cluster, default is 'default.redis7.cluster.on' | `string` | `"default.redis7.cluster.on"` | no |
| <a name="input_security_group_allow_all_within_vpc_id"></a> [security\_group\_allow\_all\_within\_vpc\_id](#input\_security\_group\_allow\_all\_within\_vpc\_id) | The security group allow all connection within vpc id | `string` | n/a | yes |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | The time to do the backup, default 01:00-02:00 | `string` | `"01:00-02:00"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet ids of this cluster | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elasticache_replication_group_port"></a> [elasticache\_replication\_group\_port](#output\_elasticache\_replication\_group\_port) | The port on which the ElastiCache replication group is accessible. |
| <a name="output_elasticache_replication_group_primary_endpoint_address"></a> [elasticache\_replication\_group\_primary\_endpoint\_address](#output\_elasticache\_replication\_group\_primary\_endpoint\_address) | The primary endpoint address of the ElastiCache replication group. |
| <a name="output_elasticache_replication_group_reader_endpoint_address"></a> [elasticache\_replication\_group\_reader\_endpoint\_address](#output\_elasticache\_replication\_group\_reader\_endpoint\_address) | The reader endpoint address of the ElastiCache replication group. |
<!-- END_TF_DOCS -->