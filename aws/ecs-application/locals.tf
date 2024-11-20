locals {
  dd_port = 8126
  container_definitions = concat([
    {
      name        = "${var.name}-container"
      image       = var.container_image
      essential   = true
      cpu         = 0
      memory      = var.container_memory
      mountPoints = []
      volumesFrom = []
      environment = var.container_environment
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      logConfiguration = {
        logDriver = "awsfirelens"
        options = {
          Name           = "datadog"
          Host           = "http-intake.logs.${var.shared_data.dd_site}"
          provider       = "ecs"
          dd_service     = var.name
          dd_source      = var.name
          dd_message_key = "log"
          dd_tags        = "project:${var.name},env:${var.environment}"
          TLS            = "on"
          retry_limit    = "2"
        }
        secretOptions = [
          {
            name      = "apikey"
            valueFrom = var.dd_api_key_arn
          }
        ]
      }
      dependsOn = [
        {
          containerName : "log_router"
          condition : "START"
        }
      ]
      secrets = var.container_secrets
      dockerLabels = {
        "com.datadoghq.ad.check_names" : "[\"${var.name}\"]",
        "com.datadoghq.ad.init_configs" : "[{}]"
        "com.datadoghq.ad.instances" : "[{\"host\": \"%%host%%\", \"port\": ${var.container_port}]",
        "com.datadoghq.ad.logs" : "[{\"auto_multi_line_detection\": true}]",
      }
    },
    {
      name        = "datadog"
      image       = var.shared_data.dd_agent_image
      essential   = true
      cpu         = 10
      memory      = 256
      mountPoints = []
      volumesFrom = []
      environment = [
        {
          "name" : "ECS_FARGATE",
          "value" : "true"
        },
        {
          "name" : "DD_SITE",
          "value" : var.shared_data.dd_site
        },
        {
          "name" : "DD_ENV",
          "value" : var.environment
        },
        {
          "name" : "DD_APM_ENABLED",
          "value" : "true"
        },
        {
          "name" : "DD_APM_NON_LOCAL_TRAFFIC",
          "value" : "true"
        },
        {
          "name" : "DD_PROCESS_AGENT_ENABLED",
          "value" : "true"
        }
      ]
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = local.dd_port
          hostPort      = local.dd_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.main.name
          awslogs-stream-prefix = "datadog"
          awslogs-region        = var.region
        }
      }

      secrets = [
        {
          name      = "DD_API_KEY"
          valueFrom = var.dd_api_key_arn
        }
      ]
    },
    {
      name         = "log_router"
      image        = "public.ecr.aws/aws-observability/aws-for-fluent-bit:stable"
      essential    = true
      cpu          = 10
      memory       = 128
      mountPoints  = []
      volumesFrom  = []
      portMappings = []
      user         = "0"
      environment  = []
      firelensConfiguration = {
        type = "fluentbit"
        options = {
          "enable-ecs-log-metadata" : "true"
        }
      }
    }
    ], [for ac_def in var.additional_container_definitions : merge(ac_def, {
      logConfiguration = {
        logDriver = "awsfirelens"
        options = {
          Name           = "datadog"
          Host           = "http-intake.logs.${var.shared_data.dd_site}"
          provider       = "ecs"
          dd_service     = ac_def.name
          dd_source      = ac_def.name
          dd_message_key = "log"
          dd_tags        = "project:${ac_def.name},env:${var.environment}"
          TLS            = "on"
          retry_limit    = "2"
        }
        secretOptions = [
          {
            name      = "apikey"
            valueFrom = var.dd_api_key_arn
          }
        ]
      }
  })])
}
