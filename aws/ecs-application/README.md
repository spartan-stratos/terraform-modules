# AWS ECS Terraform module

Terraform module which creates ECS (Elastic Container Service) resources on AWS.

This module will create the components below:

- IAM roles for task execution role and task
  roles, [definition](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html)
- ECS service with it's task, along with the definition for auto scaling based on memory and CPU
- A Route53 DNS record that register the ALB DNS name as it's target
- Registering the ECS service as the target for the input ALB, the traffic with the correct Host name will be pass
  through the ALB to this ECS service
- A security group for ECS service so that only traffic from ALB is accepted

## Usage

### Create a ECS application

```hcl
module "application" {
  source = "github.com/spartan-stratos/terraform-modules//aws/ecs-application?ref=v0.2.1"

  name                          = "example-service"
  environment                   = "dev"
  region                        = "us-west-2"
  subnet_ids = [] # the subnet objects should be passed
  additional_iam_policy_arns = []
  container_port                = 8080
  container_cpu                 = 512
  container_memory              = 2048
  alb_dns_name                  = "example.us-west-2.elb.amazonaws.com"
  alb_security_groups = ["sg-0ea3ae12345678"]
  alb_zone_id = "Z1H1FL5HABSF5" # us-west-2 hosted zone for ALB
  aws_lb_listener_arn           = "arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"
  aws_lb_listener_rule_priority = 100
  container_environment = [
    {
      name  = "MICRONAUT_ENVIRONMENTS",
      value = "dev"
    }
  ]
  container_secrets = [
    {
      name      = "DB_PASSWORD",
      valueFrom = "arn:aws:ssm:us-west-2:1234567899:parameter/DB_PASSWORD"
    }
  ]
  container_image           = "1234567899.dkr.ecr.us-west-2.amazonaws.com/example:latest"
  dns_name                  = "example"
  ecs_cluster_id            = "example-cluster-id"
  ecs_cluster_name          = "example-cluster-name"
  ecs_execution_policy_arns = []
  route53_zone_id           = "example"
  vpc_id                    = "vpc-0131eae12345678"
  service_desired_count     = 2
  service_max_capacity      = 2

  additional_container_definitions = [
    {
      name        = "api-migration"
      image       = "1234567899.dkr.ecr.us-west-2.amazonaws.com/example:migration-latest"
      essential   = false
      cpu         = 10
      memory      = 256
      mountPoints = []
      volumesFrom = []
      environment = [
        {
          "name" : "ECS_FARGATE",
          "value" : "true"
        }
      ]
      secrets = [
        {
          name      = "DB_PASSWORD"
          valueFrom = "arn:aws:ssm:us-west-2:1234567899:parameter/DB_PASSWORD"
        }
      ]
    }
  ]

  persistent_volume = null
}
```

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_efs"></a> [efs](#module\_efs) | ../efs | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.ecs_policy_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.ecs_policy_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.migration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_basic_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role_secrets_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role_ssm_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_role_additional_policies_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.ecs_tasks_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_container_definitions"></a> [additional\_container\_definitions](#input\_additional\_container\_definitions) | Custom container definition | `list(any)` | `[]` | no |
| <a name="input_additional_iam_policy_arns"></a> [additional\_iam\_policy\_arns](#input\_additional\_iam\_policy\_arns) | Additional policies for ECS task role | `list(string)` | `[]` | no |
| <a name="input_additional_port_mappings"></a> [additional\_port\_mappings](#input\_additional\_port\_mappings) | n/a | `list` | `[]` | no |
| <a name="input_alb_dns_name"></a> [alb\_dns\_name](#input\_alb\_dns\_name) | DNS name of the Application Load Balancer | `string` | n/a | yes |
| <a name="input_alb_security_groups"></a> [alb\_security\_groups](#input\_alb\_security\_groups) | List of security group IDs of the ALB | `list(string)` | n/a | yes |
| <a name="input_alb_zone_id"></a> [alb\_zone\_id](#input\_alb\_zone\_id) | Hosted zone id of the ALB | `string` | n/a | yes |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Enable to assign the public ip to the tasks | `bool` | `false` | no |
| <a name="input_aws_lb_listener_arn"></a> [aws\_lb\_listener\_arn](#input\_aws\_lb\_listener\_arn) | ARN of the ALB | `string` | n/a | yes |
| <a name="input_aws_lb_listener_rule_priority"></a> [aws\_lb\_listener\_rule\_priority](#input\_aws\_lb\_listener\_rule\_priority) | AWS LB listener rule's priority | `number` | `100` | no |
| <a name="input_awslogs_stream_prefix"></a> [awslogs\_stream\_prefix](#input\_awslogs\_stream\_prefix) | AWS logs stream prefix. | `string` | `"ecs"` | no |
| <a name="input_cloudwatch_log_group_migration_name"></a> [cloudwatch\_log\_group\_migration\_name](#input\_cloudwatch\_log\_group\_migration\_name) | Overwrite existing aws\_cloudwatch\_log\_group migration name. | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | Overwrite existing aws\_cloudwatch\_log\_group name. | `string` | `null` | no |
| <a name="input_container_command"></a> [container\_command](#input\_container\_command) | Container command. | `list(string)` | `[]` | no |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | The number of cpu units used by the task | `number` | `512` | no |
| <a name="input_container_depends_on"></a> [container\_depends\_on](#input\_container\_depends\_on) | n/a | <pre>list(object({<br/>    containerName = string<br/>    condition     = string<br/>  }))</pre> | `[]` | no |
| <a name="input_container_entryPoint"></a> [container\_entryPoint](#input\_container\_entryPoint) | Container entrypoint | `list(string)` | `[]` | no |
| <a name="input_container_environment"></a> [container\_environment](#input\_container\_environment) | The container environment variables | `list(any)` | n/a | yes |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Docker image to be launched | `string` | n/a | yes |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | The amount (in MiB) of memory used by the task | `number` | `2048` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port of container to be exposed | `number` | n/a | yes |
| <a name="input_container_secrets"></a> [container\_secrets](#input\_container\_secrets) | The container secret environment variables | <pre>list(object({<br/>    name      = string<br/>    valueFrom = string<br/>  }))</pre> | `[]` | no |
| <a name="input_dd_agent_image"></a> [dd\_agent\_image](#input\_dd\_agent\_image) | Datadog agent image. | `string` | `"public.ecr.aws/datadog/agent:latest"` | no |
| <a name="input_dd_api_key_arn"></a> [dd\_api\_key\_arn](#input\_dd\_api\_key\_arn) | n/a | `string` | `null` | no |
| <a name="input_dd_port"></a> [dd\_port](#input\_dd\_port) | Datadog agent port. | `number` | `8126` | no |
| <a name="input_dd_site"></a> [dd\_site](#input\_dd\_site) | n/a | `string` | `null` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | DNS name for the ECS application | `string` | n/a | yes |
| <a name="input_ecs_cluster_id"></a> [ecs\_cluster\_id](#input\_ecs\_cluster\_id) | ID of the ECS cluster for this ECS application | `string` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of the ECS cluster for this ECS application | `string` | n/a | yes |
| <a name="input_ecs_execution_policy_arns"></a> [ecs\_execution\_policy\_arns](#input\_ecs\_execution\_policy\_arns) | Permission to make AWS API calls | `list(string)` | n/a | yes |
| <a name="input_enabled_datadog_sidecar"></a> [enabled\_datadog\_sidecar](#input\_enabled\_datadog\_sidecar) | Whether to use Datadog sidecar for monitoring and logging. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | `"dev"` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Enable to force a new task deployment of the service | `bool` | `true` | no |
| <a name="input_health_check_enabled"></a> [health\_check\_enabled](#input\_health\_check\_enabled) | Specify whether enabling health check for this ECS service or not | `bool` | `true` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Default path for health check requests | `string` | `"/health"` | no |
| <a name="input_is_worker"></a> [is\_worker](#input\_is\_worker) | Whether if this application is a worker. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name ECS application | `string` | n/a | yes |
| <a name="input_overwrite_task_execution_role_name"></a> [overwrite\_task\_execution\_role\_name](#input\_overwrite\_task\_execution\_role\_name) | Overwrite ECS task execution role name. | `string` | `null` | no |
| <a name="input_overwrite_task_role_name"></a> [overwrite\_task\_role\_name](#input\_overwrite\_task\_role\_name) | Overwrite ECS task role name. | `string` | `null` | no |
| <a name="input_persistent_volume"></a> [persistent\_volume](#input\_persistent\_volume) | Directory path for the EFS volume | <pre>object({<br/>    path = string,<br/>    gid  = optional(number, 1000)<br/>    uid  = optional(number, 1000)<br/>  })</pre> | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region in which resources are created | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | R53 zone ID | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security groups to associate with the task or service | `list(string)` | `[]` | no |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | Number of services running in parallel | `number` | `2` | no |
| <a name="input_service_max_capacity"></a> [service\_max\_capacity](#input\_service\_max\_capacity) | Maximum of services running in parallel | `number` | `2` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets to associate with the task or service | `list(string)` | `[]` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | Task cpu. | `number` | n/a | yes |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | Task memory. | `number` | n/a | yes |
| <a name="input_task_policy_secrets_description"></a> [task\_policy\_secrets\_description](#input\_task\_policy\_secrets\_description) | The description of IAM policy for task secrets. | `string` | `"Policy that allows access to the ssm we created"` | no |
| <a name="input_task_policy_ssm_description"></a> [task\_policy\_ssm\_description](#input\_task\_policy\_ssm\_description) | The description of IAM policy for task ssm. | `string` | `"Policy that allows access to the ssm we created"` | no |
| <a name="input_user"></a> [user](#input\_user) | User to run the container | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_container_definitions"></a> [additional\_container\_definitions](#output\_additional\_container\_definitions) | The additional container definitions of ECS application |
| <a name="output_alb_target_group_arn"></a> [alb\_target\_group\_arn](#output\_alb\_target\_group\_arn) | The ALB ARN of ECS application |
| <a name="output_application_domain_name"></a> [application\_domain\_name](#output\_application\_domain\_name) | The domain name of ECS application |
| <a name="output_container_definitions"></a> [container\_definitions](#output\_container\_definitions) | The container definitions of ECS application |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | The ECS service name |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | The task role arn |
<!-- END_TF_DOCS -->
