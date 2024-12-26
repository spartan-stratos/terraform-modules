# AWS Security Groups Terraform module
Terraform module which creates Security Groups resources on AWS.

This module will create the following components:
- AWS Security Groups
- Security Group Rules (Ingress and Egress)

## Usage
### Create Custom Security Groups
```hcl
module "security_groups" {
  source = "github.com/spartan-stratos/terraform-modules//aws/security-group?ref=v0.1.23"
  
  create_default_security_group = false
  security_groups = [
    {
      name                     = "example-sg"
      description              = "Example Security Group"
      vpc_id                   = "vpc-12345678"
      ingress_rules            = ["http"]
      ingress_cidr_blocks      = ["0.0.0.0/0"]
      ingress_ipv6_cidr_blocks = []
      ingress_self             = [true]
      egress_rules             = ["https"]
      egress_cidr_blocks       = ["0.0.0.0/0"]
      egress_ipv6_cidr_blocks  = []
      egress_self              = []
    }
  ]

  rules = {
    "allow-all" = [0, 0, "-1", "example-rule"]
  }
}
```

### Create Default Security Groups
```hcl
module "security_groups" {
  source = "github.com/spartan-stratos/terraform-modules//aws/security-group?ref=v0.1.23"

  create_default_security_group = true
  vpc_id                        = "vpc-12345678"
  cidr_blocks                   = ["10.0.0.0/16"]
}
```

## Examples
- [Example](./examples/complete/)

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
| [aws_security_group.allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.allow_all_within_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of allowed CIDR blocks used to define ingress/egress rules for the security groups. | `list(string)` | `[]` | no |
| <a name="input_create_default_security_group"></a> [create\_default\_security\_group](#input\_create\_default\_security\_group) | Flag to determine whether a default security group should be created. | `bool` | `true` | no |
| <a name="input_custom_sg_allow_all_description"></a> [custom\_sg\_allow\_all\_description](#input\_custom\_sg\_allow\_all\_description) | Custom description for security group allow all `aws_security_group.allow_all`. | `string` | `null` | no |
| <a name="input_custom_sg_allow_all_within_vpc_description"></a> [custom\_sg\_allow\_all\_within\_vpc\_description](#input\_custom\_sg\_allow\_all\_within\_vpc\_description) | Custom description for security group allow all within vpc `aws_security_group.allow_all_within_vpc`. | `string` | `null` | no |
| <a name="input_custom_sg_allow_all_within_vpc_egress_ipv6_cidr_blocks"></a> [custom\_sg\_allow\_all\_within\_vpc\_egress\_ipv6\_cidr\_blocks](#input\_custom\_sg\_allow\_all\_within\_vpc\_egress\_ipv6\_cidr\_blocks) | Custom IPv6 CIDR blocks to allow in the egress rules for the security group allow\_all\_within\_vpc | `list(string)` | <pre>[<br/>  "::/0"<br/>]</pre> | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description']) | `map(list(any))` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of objects defining custom security groups. Each security group object should include the following properties:<br/>- `name` (string): The name of the security group.<br/>- `description` (string): A description of the security group's purpose.<br/>- `vpc_id` (string): The VPC ID where the security group will be created.<br/>- `ingress_rules` (list(string)): A list of ingress rule names defined in the `rules` variable.<br/>- `ingress_cidr_blocks` (optional, list(string)): CIDR blocks to allow in the ingress rules. Default is an empty list.<br/>- `ingress_ipv6_cidr_blocks` (optional, list(string)): IPv6 CIDR blocks to allow in the ingress rules. Default is an empty list.<br/>- `ingress_self` (optional, list(bool)): Whether to allow self-referencing ingress rules. Default is an empty list.<br/>- `egress_rules` (list(string)): A list of egress rule names defined in the `rules` variable.<br/>- `egress_cidr_blocks` (optional, list(string)): CIDR blocks to allow in the egress rules. Default is an empty list.<br/>- `egress_ipv6_cidr_blocks` (optional, list(string)): IPv6 CIDR blocks to allow in the egress rules. Default is an empty list.<br/>- `egress_self` (optional, list(bool)): Whether to allow self-referencing egress rules. Default is an empty list. | <pre>list(object({<br/>    name                     = string<br/>    description              = string<br/>    vpc_id                   = string<br/>    ingress_rules            = list(string)<br/>    ingress_cidr_blocks      = optional(list(string))<br/>    ingress_ipv6_cidr_blocks = optional(list(string))<br/>    ingress_self             = optional(list(bool))<br/>    egress_rules             = list(string)<br/>    egress_cidr_blocks       = optional(list(string))<br/>    egress_ipv6_cidr_blocks  = optional(list(string))<br/>    egress_self              = optional(list(bool))<br/>  }))</pre> | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the main VPC associated with the security groups. Can be null if not provided. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_allow_all_id"></a> [security\_group\_allow\_all\_id](#output\_security\_group\_allow\_all\_id) | The ID of the 'allow all' security group. |
| <a name="output_security_group_allow_all_within_vpc_id"></a> [security\_group\_allow\_all\_within\_vpc\_id](#output\_security\_group\_allow\_all\_within\_vpc\_id) | The ID of the 'allow all within VPC' security group. |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | Map of security group names to their IDs |
<!-- END_TF_DOCS -->
