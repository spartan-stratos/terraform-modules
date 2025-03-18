# Changelog

All notable changes to this project will be documented in this file.

## [0.2.4]() (2025-03-18)

### Bug Fixes

* Add object attribute `name` to variable `additional_port_mappings`.

## [0.2.3]() (2025-03-18)

### Features

* Add variable `port_mapping_name` for service connect.

## [0.2.2]() (2025-03-18)

### Features

* Add ECS Service Connect using `enabled_service_connect` and `service_connect_configuration`.

## [0.2.1]() (2025-03-18)

### Features

* Introduces new variables:
    * `task_cpu` and `task_memory`: to define task resources, container resource defined
      by `container_cpu`, `container_memory`.
    * `cloudwatch_log_group_name`, `cloudwatch_log_group_migration_name`: to define cloudwatch log group name.
      If `cloudwatch_log_group_migration_name` is not null, it will create a log group for service migration logs.
    * `overwrite_task_role_name`, `overwrite_task_execution_role_name`, `task_policy_secrets_description`, `task_policy_ssm_description`:
      fallback on default value.
    * `enabled_datadog_sidecar`, `dd_site`, `dd_api_key_arn`, `dd_agent_image`, `dd_port`: supports datadog sidecar
      definitions.
    * `use_alb`: whether to use ALB.
    * `enabled_port_mapping`: whether to use TCP port mapping to service container.

## [0.1.78]() (2025-03-10)

### Features

* Add `persistent_volume` and integrate with EFS service

## [0.1.67]() (2025-02-17)

### Features

* Add flag `assign_public_ip`

## [0.1.63]() (2025-01-24)

### Features

* Refactor module, remove datadog configuration

## [0.1.4]() (2024-12-05)

### Features

* Update terraform version constraint from `~> 1.9.8` to `>= 1.9.8`

## [0.1.0]() (2024-11-06)

### Features

* Initial commit with all the code
