locals {
  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group"         = aws_cloudwatch_log_group.this.name
      "awslogs-region"        = var.region
      "awslogs-stream-prefix" = "ecs"
    }
  }

  additional_container_with_log_definitions = [for definition in var.additional_container_definitions : merge(definition, { logConfiguration = local.log_configuration })]

  container_definitions = concat([
    {
      name      = "${var.name}-container"
      image     = var.container_image
      essential = true
      user      = var.user
      cpu       = 0
      memory    = var.container_memory
      mountPoints = var.persistent_volume != null ? [
        {
          sourceVolume  = var.name
          containerPath = var.persistent_volume.path
          readOnly      = false
        }
      ] : []
      volumesFrom = []
      environment = var.container_environment
      secrets     = var.container_secrets
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      logConfiguration = local.log_configuration
  }], local.additional_container_with_log_definitions)
}
