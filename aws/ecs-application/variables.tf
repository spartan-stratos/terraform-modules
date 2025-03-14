variable "name" {
  description = "The name ECS application"
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
  type        = list(any)
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

variable "vpc_id" {
  description = "VPC ID"
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
