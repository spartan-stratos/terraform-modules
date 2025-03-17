locals {
  cloudwatch_log_group_name = var.cloudwatch_log_group_name != null ? var.cloudwatch_log_group_name : "${var.name}-task"

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group"         = aws_cloudwatch_log_group.this.name
      "awslogs-region"        = var.region
      "awslogs-stream-prefix" = var.awslogs_stream_prefix
    }
    secretOptions = []
  }

  additional_container_with_log_definitions = [
    for definition in var.additional_container_definitions : merge(
      {
        secrets     = var.container_secrets
        environment = var.container_environment
        logConfiguration = var.enabled_datadog_sidecar ? {
          logDriver = "awsfirelens"
          options = {
            Name           = "datadog"
            Host           = "http-intake.logs.${var.dd_site}"
            provider       = "ecs"
            dd_service     = definition.name
            dd_source      = definition.name
            dd_message_key = "log"
            dd_tags        = "project:${definition.name},env:${var.environment}"
            TLS            = "on"
            retry_limit    = "2"
          }
          secretOptions = [
            {
              name      = "apikey"
              valueFrom = var.dd_api_key_arn
            }
          ]
        } : local.log_configuration
      },
    definition)
  ]

  service_container_definition = [
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
      portMappings = concat(
        [{
          protocol      = "tcp"
          containerPort = var.container_port
          hostPort      = var.container_port
        }],
        var.additional_port_mappings
      )
      dockerLabels = var.enabled_datadog_sidecar ? {
        "com.datadoghq.ad.check_names" : "[\"${var.name}\"]",
        "com.datadoghq.ad.init_configs" : "[{}]"
        "com.datadoghq.ad.instances" : "[{\"host\": \"%%host%%\", \"port\": ${var.container_port}]",
        "com.datadoghq.ad.logs" : "[{\"auto_multi_line_detection\": true}]",
      } : {}
      command    = var.container_command
      entryPoint = var.container_entryPoint
      logConfiguration = var.enabled_datadog_sidecar ? {
        logDriver = "awsfirelens"
        options = {
          Name           = "datadog"
          Host           = "http-intake.logs.${var.dd_site}"
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
      } : local.log_configuration
      dependsOn = var.enabled_datadog_sidecar ? [
        {
          containerName : "log_router"
          condition : "START"
        }
      ] : []
    },
  ]

  dd_container_definitions = [
    // using fluent-bit to send logs directly to datadog
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
      secrets      = []
      firelensConfiguration = {
        type = "fluentbit"
        options = {
          "enable-ecs-log-metadata" : "true"
        }
      }
    },
    // datadog sidecar
    {
      name        = "datadog"
      image       = var.dd_agent_image
      essential   = true
      cpu         = 10
      memory      = 256
      mountPoints = []
      volumesFrom = []

      environment = [
        {
          "name" : "DD_APM_ENABLED",
          "value" : "true"
        },
        {
          "name" : "DD_APM_NON_LOCAL_TRAFFIC",
          "value" : "true"
        },
        {
          "name" : "DD_ENV",
          "value" : var.environment
        },
        {
          "name" : "DD_LOG_LEVEL",
          "value" : "warn"
        },
        {
          "name" : "DD_PROCESS_AGENT_ENABLED",
          "value" : "true"
        },
        {
          "name" : "DD_SITE",
          "value" : var.dd_site
        },
        {
          "name" : "ECS_FARGATE",
          "value" : "true"
        }
      ]

      portMappings = [
        {
          protocol      = "tcp"
          containerPort = var.dd_port
          hostPort      = var.dd_port
        }
      ]

      secrets = [
        {
          name      = "DD_API_KEY"
          valueFrom = var.dd_api_key_arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-stream-prefix = "${var.name}-datadog"
          awslogs-region        = var.region
        }
        secretOptions = []
      }
    }
  ]

  container_definitions = concat(
    local.service_container_definition,
    local.dd_container_definitions,
    local.additional_container_with_log_definitions,
  )
}
