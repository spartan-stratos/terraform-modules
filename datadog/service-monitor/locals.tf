locals {
  notifiers = "@slack-${var.notification_slack_channel_prefix}${var.environment}"

  message = var.environment == "prod" ? "${local.notifiers} <!channel>" : "${local.notifiers}"

  notification_preset_name = "hide_all"

  enabled_include_tags = false

  query_hit = {
    critical          = 5000
    critical_recovery = 3000
    renotify_interval = 60
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 5
      prod = 5
    }
  }

  error_hit = {
    critical          = 5
    critical_recovery = 0
    renotify_interval = 50
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 3
      prod = 3
    }
  }

  cpu = {
    critical          = 80
    critical_recovery = 70
    renotify_interval = 30
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 2
      prod = 2
    }
  }

  cpu_o1 = {
    critical          = 70
    critical_recovery = 40
    renotify_interval = 50
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 3
      prod = 3
    }
  }

  memory = {
    critical          = 80
    critical_recovery = 70
    renotify_interval = 30
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 2
      prod = 2
    }
  }

  memory_o1 = {
    critical          = 70
    critical_recovery = 40
    renotify_interval = 50
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 3
      prod = 3
    }
  }

  restart_time_o1 = {
    critical          = 1
    renotify_interval = 30
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 2
      prod = 2
    }
  }

  restart_time = {
    critical          = 2
    critical_recovery = 1
    renotify_interval = 10
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 1
      prod = 1
    }
  }

  crash_loop_back_off_time_o1 = {
    critical          = 1
    renotify_interval = 30
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 2
      prod = 2
    }
  }

  crash_loop_back_off_time = {
    critical          = 2
    critical_recovery = 1
    renotify_interval = 10
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 1
      prod = 1
    }
  }

  image_pull_back_off_time_o1 = {
    critical          = 1
    renotify_interval = 30
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 2
      prod = 2
    }
  }

  image_pull_back_off_time = {
    critical          = 2
    critical_recovery = 1
    renotify_interval = 10
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 1
      prod = 1
    }
  }

  failed_pods_time_o1 = {
    critical          = 1
    renotify_interval = 30
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 2
      prod = 2
    }
  }

  failed_pods_time = {
    critical          = 2
    critical_recovery = 1
    renotify_interval = 10
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 1
      prod = 1
    }
  }

  p95 = {
    critical          = 1
    critical_recovery = 0.9
    renotify_interval = 30
    timeframe         = "last_5m"
    priority_levels = {
      dev  = 2
      prod = 2
    }
  }
}
