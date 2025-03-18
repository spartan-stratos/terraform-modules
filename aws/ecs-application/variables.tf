# general
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "The AWS region in which resources are created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnets to associate with the task or service"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of security groups to associate with the task or service"
  type        = list(string)
  default     = []
}

# ecs
variable "name" {
  description = "The name ECS application"
  type        = string
}

variable "task_memory" {
  description = "Task memory."
  type        = number
}

variable "task_cpu" {
  description = "Task cpu."
  type        = number
}

variable "container_port" {
  description = "Port of container to be exposed"
  type        = number
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  type        = number
  default     = 512
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  type        = number
  default     = 2048
}

variable "container_image" {
  description = "Docker image to be launched"
  type        = string
}

variable "container_secrets" {
  description = "The container secret environment variables"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "container_environment" {
  description = "The container environment variables"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "service_desired_count" {
  description = "Number of services running in parallel"
  type        = number
  default     = 2
}

variable "service_max_capacity" {
  description = "Maximum of services running in parallel"
  type        = number
  default     = 2
}

variable "ecs_execution_policy_arns" {
  description = "Permission to make AWS API calls"
  type        = list(string)
}

variable "ecs_cluster_id" {
  description = "ID of the ECS cluster for this ECS application"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster for this ECS application"
  type        = string
}

variable "health_check_enabled" {
  description = "Specify whether enabling health check for this ECS service or not"
  type        = bool
  default     = true
}

variable "health_check_path" {
  description = "Default path for health check requests"
  type        = string
  default     = "/health"
}

variable "force_new_deployment" {
  description = "Enable to force a new task deployment of the service"
  type        = bool
  default     = true
}

variable "additional_iam_policy_arns" {
  description = "Additional policies for ECS task role"
  type        = list(string)
  default     = []
}

variable "additional_container_definitions" {
  description = "Custom container definition"
  type        = list(any)
  default     = []
}

variable "additional_port_mappings" {
  description = "Additional port mappings to service container."
  type = list(object({
    protocol      = string
    containerPort = number
    hostPort      = number
  }))
  default = []
}

variable "enabled_port_mapping" {
  description = "Whether to use TCP port mapping to service container."
  type        = bool
  default     = true
}

variable "assign_public_ip" {
  description = "Enable to assign the public ip to the tasks"
  type        = bool
  default     = false
}

variable "persistent_volume" {
  description = "Directory path for the EFS volume"
  type = object({
    path = string,
    gid  = optional(number, 1000)
    uid  = optional(number, 1000)
  })
  default = null
}

variable "user" {
  description = "User to run the container"
  type        = string
  default     = null
}

variable "use_alb" {
  description = "Whether to use alb for this ecs task."
  type        = bool
  default     = true
}

variable "container_command" {
  description = "Container command."
  type        = list(string)
  default     = []
}

variable "container_entryPoint" {
  description = "Container entrypoint"
  type        = list(string)
  default     = []
}

variable "awslogs_stream_prefix" {
  description = "AWS logs stream prefix."
  type        = string
  default     = "ecs"
}

variable "container_depends_on" {
  type = list(object({
    containerName = string
    condition     = string
  }))
  default = []
}

# alb & r53
variable "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  type        = string
}

variable "alb_security_groups" {
  description = "List of security group IDs of the ALB"
  type        = list(string)
}

variable "aws_lb_listener_arn" {
  description = "ARN of the ALB"
  type        = string
}

variable "aws_lb_listener_rule_priority" {
  description = "AWS LB listener rule's priority"
  type        = number
  default     = 100
}

variable "alb_zone_id" {
  description = "Hosted zone id of the ALB"
  type        = string
}

variable "dns_name" {
  description = "DNS name for the ECS application"
  type        = string
}

variable "route53_zone_id" {
  description = "R53 zone ID"
  type        = string
}

# cloudwatch
variable "cloudwatch_log_group_name" {
  description = "Overwrite existing aws_cloudwatch_log_group name."
  type        = string
  default     = null
}

## flyway log
variable "cloudwatch_log_group_migration_name" {
  description = "Overwrite existing aws_cloudwatch_log_group migration name."
  type        = string
  default     = null
}

# iam
variable "overwrite_task_execution_role_name" {
  description = "Overwrite ECS task execution role name."
  type        = string
  default     = null
}

variable "overwrite_task_role_name" {
  description = "Overwrite ECS task role name."
  type        = string
  default     = null
}

variable "task_policy_secrets_description" {
  description = "The description of IAM policy for task secrets."
  type        = string
  default     = "Policy that allows access to the ssm we created"
}

variable "task_policy_ssm_description" {
  description = "The description of IAM policy for task ssm."
  type        = string
  default     = "Policy that allows access to the ssm we created"
}

# datadog
variable "enabled_datadog_sidecar" {
  description = "Whether to use Datadog sidecar for monitoring and logging."
  type        = bool
  default     = false
}

variable "dd_site" {
  type    = string
  default = null
}

variable "dd_api_key_arn" {
  type    = string
  default = null
}

variable "dd_agent_image" {
  description = "Datadog agent image."
  type        = string
  default     = "public.ecr.aws/datadog/agent:latest"
}

variable "dd_port" {
  description = "Datadog agent port."
  type        = number
  default     = 8126
}
