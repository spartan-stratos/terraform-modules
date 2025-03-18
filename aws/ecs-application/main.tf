/*
aws_cloudwatch_log_group provides a CloudWatch Log Group resource for awslogs driver.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
*/
resource "aws_cloudwatch_log_group" "this" {
  name = "/ecs/${local.cloudwatch_log_group_name}"

  tags = {
    Name        = local.cloudwatch_log_group_name
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "migration" {
  count = var.cloudwatch_log_group_migration_name != null ? 1 : 0

  name = "/ecs/${var.cloudwatch_log_group_migration_name}"

  tags = {
    Name        = var.cloudwatch_log_group_migration_name
    Environment = var.environment
  }
}

/*
aws_ecs_service provides an ECS service - effectively a task that is expected to run until an error occurs or a user terminates it (typically a webserver or a database).
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
*/
resource "aws_ecs_service" "this" {
  name                               = var.name
  cluster                            = var.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = var.service_desired_count
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 60
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  force_new_deployment               = var.force_new_deployment

  network_configuration {
    security_groups  = compact(concat([try(aws_security_group.this[0].id, null)], var.security_group_ids))
    subnets          = var.subnet_ids
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.use_alb ? [1] : []

    content {
      container_name   = "${var.name}-container"
      container_port   = var.container_port
      target_group_arn = try(aws_lb_target_group.this[0].arn, null)
    }
  }

  # desired_count is ignored as it can change due to autoscaling policy
  lifecycle {
    ignore_changes = [desired_count]
  }
}

/*
aws_ecs_task_definition manages a revision of an ECS task definition to be used in aws_ecs_service.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
*/
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  /**
   * 256 (.25 vCPU) - 512 MB, 1 GB, 2 GB
   * 512 (.5 vCPU) - 1 GB, 2 GB, 3 GB, 4 GB
   * 1024 (1 vCPU) - 2 GB, 3 GB, 4 GB, 5 GB, 6 GB, 7 GB, 8 GB
   * 2048 (2 vCPU) - Between 4 GB and 16 GB in 1 GB increments
   * 4096 (4 vCPU) - Between 8 GB and 30 GB in 1 GB increments
   * 8192 (8 vCPU) - Between 16 GB and 60 GB in 4 GB increments
   * 16384 (16vCPU) - Between 32 GB and 120 GB in 8 GB increments
   */
  cpu                   = var.task_cpu
  memory                = var.task_memory
  execution_role_arn    = aws_iam_role.task_execution_role.arn
  task_role_arn         = aws_iam_role.task_role.arn
  container_definitions = jsonencode(local.container_definitions)

  dynamic "volume" {
    for_each = var.persistent_volume != null ? [var.name] : []
    content {
      name = volume.value
      efs_volume_configuration {
        file_system_id = module.efs[0].file_system_id

        transit_encryption      = "ENABLED"
        transit_encryption_port = 2999

        authorization_config {
          access_point_id = module.efs[0].access_points[volume.value].id
          iam             = "ENABLED"
        }
      }
    }
  }

  tags = {
    Name        = "${var.name}-task"
    Environment = var.environment
  }
}

/*
aws_appautoscaling_target provides an Application AutoScaling ScalableTarget resource.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target
*/
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.service_max_capacity
  min_capacity       = var.service_desired_count
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

/*
aws_appautoscaling_policy provides an Application AutoScaling Policy resource.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy
*/
resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  name               = "memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 60
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
