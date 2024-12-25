# AWS CloudWatch VPC Flow Logs Terraform module
Terraform module which configure publishing VPC flow logs to CloudWatch Logs

https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-cwl.html
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
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
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_flow_log.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | The name use to generate CloudWatch log group to send VPC flow logs to | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The number of days to retain log events | `number` | `90` | no |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL | `string` | `"ALL"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to monitor | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
