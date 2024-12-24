# AWS Security Groups Terraform module
Terraform module which creates Security Groups resources on AWS.

This module will create the following components:
- AWS Security Groups
- Security Group Rules (Ingress and Egress)

## Usage
### Create Security Groups
```hcl
module "security_groups" {
  source = "github.com/spartan-stratos/terraform-modules//aws/security-group?ref=v0.1.21"

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
| <a name="input_rules"></a> [rules](#input\_rules) | Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description']) | `map(list(any))` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | <pre>list(object({<br/>    name                     = string<br/>    description              = string<br/>    vpc_id                   = string<br/>    ingress_rules            = list(string)<br/>    ingress_cidr_blocks      = optional(list(string))<br/>    ingress_ipv6_cidr_blocks = optional(list(string))<br/>    ingress_self             = optional(list(bool))<br/>    egress_rules             = list(string)<br/>    egress_cidr_blocks       = optional(list(string))<br/>    egress_ipv6_cidr_blocks  = optional(list(string))<br/>    egress_self              = optional(list(bool))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | Map of security group names to their IDs |
<!-- END_TF_DOCS -->
