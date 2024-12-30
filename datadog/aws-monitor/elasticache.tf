module "elasticache" {
  source = "../monitors"

  notification_slack_channel_prefix = var.notification_slack_channel_prefix
  tag_slack_channel                 = var.tag_slack_channel
  environment                       = var.environment
  service                           = "elasticache"

  monitors = local.elasticache_monitors
}

locals {
  default_elasticache_monitors = {
    elasticache_cpu = {
      priority_level = 2
      title_tags     = "[High CPU Utilization] [ElastiCache]"
      title          = "ElastiCache CPU Utilization is too high."

      query_template = "avg($${timeframe}):sum:aws.elasticache.cpuutilization{environment:${var.environment}, aws_account:${var.aws_account_id}} by {engine} > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
      }

      threshold_critical          = 80
      threshold_critical_recovery = 40
      renotify_interval           = 20
    }

    elasticache_cpu_o1 = {
      priority_level = 3
      title_tags     = "[High CPU Utilization] [ElastiCache]"
      title          = "Elasticache CPU Utilization is high."

      query_template = "avg($${timeframe}):sum:aws.elasticache.cpuutilization{environment:${var.environment}, aws_account:${var.aws_account_id}} by {engine} > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
      }

      threshold_critical          = 70
      threshold_critical_recovery = 40
      renotify_interval           = 50
    }

    elasticache_memory = {
      priority_level = 2
      title_tags     = "[High Memory Utilization] [ElastiCache]"
      title          = "Elasticache Memory Utilization is too high."

      query_template = "avg($${timeframe}):sum:aws.elasticache.database_memory_usage_percentage{aws_account:${var.aws_account_id}, environment:${var.environment}} > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
      }

      threshold_critical          = 80
      threshold_critical_recovery = 70
      renotify_interval           = 30
      require_full_window         = false
    }

    elasticache_memory_o1 = {
      priority_level = 3
      title_tags     = "[High Memory Utilization] [ElastiCache]"
      title          = "Elasticache Memory Utilization is high."

      query_template = "avg($${timeframe}):sum:aws.elasticache.database_memory_usage_percentage{aws_account:${var.aws_account_id}, environment:${var.environment}} > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
      }

      threshold_critical          = 70
      threshold_critical_recovery = 40
      renotify_interval           = 50
      require_full_window         = false
    }

    elasticache_cache_errors = {
      priority_level = 3
      title_tags     = "[High Cache Errors] [ElastiCache]"
      title          = "Elasticache Cache Error is high"

      query_template = "sum($${timeframe}):sum:aws.elasticache.cache_misses{environment:${var.environment}}.as_count() > $${threshold_critical}"
      query_args = {
        timeframe = "last_5m"
      }

      threshold_critical          = 15
      threshold_critical_recovery = 0
      renotify_interval           = 50
    }
  }
  elasticache_monitors = {
    for monitor, config in local.default_elasticache_monitors : monitor => merge(config, try(var.override_default_monitors[monitor]))
  }
}
